---
name: shell-scripting-safe
description: Úsalo al crear, revisar o refactorizar scripts de shell o Bash, para garantizar robustez, seguridad y portabilidad.
---

# 🎯 Propósito
Escribir scripts de shell (Bash) que **fallen rápido**, no destruyan datos por accidente y sean
fáciles de mantener. Aplica a cualquier `.sh`, tareas de CI/CD, despliegues y administración de sistemas.

# 🚦 Cuándo usarla (Triggers)
Activa esta skill siempre que:
- Crees o modifiques un script `.sh` o `.bash`.
- Automatices tareas de sistema, despliegue o CI/CD.
- El usuario pida "un script que…".

# 📋 Prerrequisitos (Pre-flight checks)
1. Confirma el intérprete objetivo: `#!/usr/bin/env bash`. Si necesitas POSIX puro, usa `#!/bin/sh` y evita extensiones de Bash.
2. Comprueba que el script no va a ejecutarse como `root` sin necesidad.

# 🛠️ Flujo de Trabajo (SOP)

## Paso 1: Cabecera y modo estricto (fail fast)
- Empieza SIEMPRE con el shebang y `set -euo pipefail`.
- Añade `IFS=$'\n\t'` si vas a iterar sobre listas.

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
```

## Paso 2: Variables y quoting
- Cita SIEMPRE las variables: `"$var"`, `"${arr[@]}"`.
- Usa `readonly` para constantes y `"${var:-default}"` para valores por defecto.
- Valida los parámetros de entrada; no uses `$1 $2` a ciegas.

## Paso 3: Manejo de errores y limpieza
- Usa `trap` para limpiar archivos temporales al salir.
- Manda los errores a `stderr` (`>&2`) y devuelve códigos de salida distintos de 0.

```bash
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
```

## Paso 4: Validación
- Pasa `shellcheck` sobre el script antes de darlo por terminado.
- Pruébalo en un entorno seguro (contenedor) antes de tocar producción.

# 🛑 Reglas y Restricciones (Anti-patrones)
- **NUNCA** hagas `chmod 777`; usa el permiso mínimo necesario (ej. `chmod 750`).
- **NUNCA** uses `rm -rf "$var"` sin comprobar que `$var` no está vacío.
- **NUNCA** parsees la salida de `ls`; usa *globs* o `find … -print0`.
- **NUNCA** hagas `cd "$dir"` sin comprobar el resultado.
- **SIEMPRE** cita variables y usa `[[ ]]` en Bash.

# 💡 Ejemplos

**❌ MAL:**
```bash
# Sin fail-fast, sin quoting, peligroso
cd $DIR
rm -rf $TARGET/*
cp *.txt $DEST
```

**✅ BIEN:**
```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly DIR="${1:?Uso: script.sh <directorio>}"
TARGET="${2:-output}"

[[ -d "$DIR" ]] || { echo "No existe: $DIR" >&2; exit 1; }
cd "$DIR"

# Valida el destino ANTES de borrar nada
[[ -n "$TARGET" && "$TARGET" != "/" ]] || { echo "TARGET inválido" >&2; exit 1; }
mkdir -p "$TARGET"
find . -maxdepth 1 -name '*.txt' -print0 | xargs -0 -I{} cp {} "$TARGET"
```
