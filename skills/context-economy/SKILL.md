---
name: context-economy
description: Navega el repositorio leyendo lo mínimo necesario para ahorrar tokens sin perder precisión; úsala antes de explorar código desconocido o cuando haya que leer archivos grandes.
---

# 🎯 Propósito

Reducir el contexto que consumes al navegar un repositorio **sin perder precisión**. Esta skill
convierte "abrir archivos hasta encontrar algo" en un proceso dirigido:

> **Mapa → localizar → leer ventana → apuntar → verificar → entregar.**

La regla completa está en [`rules/context-economy.md`](../../rules/context-economy.md).

# 🚦 Cuándo usarla (Triggers)

Actívala cuando:

- Vayas a explorar un repositorio o módulo **desconocido**.
- La tarea te empujaría a leer **muchos archivos**.
- Empieces a "adivinar" en vez de **localizar**.
- Estés a punto de **pegar archivos enteros** en la respuesta.

# 📋 Prerrequisitos (Pre-flight checks)

1. Si existe **`REPO-MAP.md`** en la raíz, **léelo primero**.
2. Si no existe, ofrécete a generarlo una vez con
   [`templates/REPO-MAP.template.md`](../../templates/REPO-MAP.template.md).
3. Ten claro **qué** necesitas encontrar antes de empezar a buscar.

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)

Sigue estos pasos en orden.

## Paso 1 — Mapa

- Lee `REPO-MAP.md` (qué es el proyecto, entry points, estructura, dónde vive cada cosa).
- Si no hay mapa, empieza por el `README.md` y el `AGENTS.md` del proyecto.

## Paso 2 — Localizar

- Busca **antes** de leer: `grep -n` con filtros (tipo de archivo, carpeta), `glob`, o la
  herramienta de búsqueda disponible.
- Para preguntas de **estructura** (dónde está, quién llama, qué impacto), usa herramientas
  estructurales si existen (grafo de código, LSP).
- Para **texto literal** (cadenas, logs, config), usa búsqueda de texto.
- Ordena los resultados por relevancia. **No leas todas las coincidencias.**

## Paso 3 — Leer ventana

- Lee **solo el bloque relevante**: un rango de líneas o un símbolo.
- Si necesitas más, **amplía el rango**; no releas desde cero.
- Nunca leas un archivo completo para usar una parte pequeña.

## Paso 4 — Apuntar

- Anota lo aprendido en unas notas de sesión (`.agent/context.md` o similar): rutas,
  símbolos, decisiones y trampas.
- Objetivo: **no volver a descubrir lo mismo** en la misma sesión ni en la siguiente.

## Paso 5 — Verificar

- Ejecuta la comprobación **mínima** (test del módulo, linter del archivo, build acotado).
- Escala a la suite completa solo si el cambio es transversal.

## Paso 6 — Entregar

- Responde con **el cambio** (diff) y un **resumen breve**.
- No vuelques archivos completos ni repitas el código que no cambió.

# 🛑 Reglas y Restricciones (Anti-patrones)

- **NUNCA** abras archivos "por si acaso".
- **NUNCA** repitas una búsqueda ya hecha en la sesión.
- **NUNCA** comprimas información crítica sin verificar que no cambia el significado.
- **SIEMPRE** cita ruta y rango al referenciar código.
- **La corrección manda:** si dudas, lee más.

# 💡 Ejemplo

**Petición:** *"Arregla el login."*

| ❌ Sin la skill | ✅ Con la skill |
|---|---|
| Abre 15 archivos y los lee enteros | Lee `REPO-MAP.md` → `auth/` |
| ~30.000 tokens | Busca `login` → lee 2 bloques |
| | ~3.000 tokens |

# 📊 Antes / después

| | Sin mapa | Con mapa + lecturas dirigidas |
|---|---|---|
| Archivos leídos | 10-20 | 2-5 |
| Tokens (orientativo) | 30.000 | 3.000 |
| Resultado | El mismo | El mismo |

# ✅ Checklist rápido

- [ ] Leí el `REPO-MAP.md` (si existe).
- [ ] Localicé antes de leer.
- [ ] Leí solo lo necesario.
- [ ] Apunté lo aprendido.
- [ ] Verifiqué lo mínimo.
- [ ] Entregué un diff, no un archivo entero.
