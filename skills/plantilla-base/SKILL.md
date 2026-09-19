---
name: nombre-de-la-skill-en-kebab-case
description: Breve descripción (máx 2 líneas). Debe incluir las "palabras clave" que el usuario diría para que el agente sepa cuándo activarla. Ej: "Úsalo para inicializar un proyecto Docker o escribir un Dockerfile."
---

# 🎯 Propósito
Explica en detalle para qué sirve esta skill. El agente leerá esto tras activarla para confirmar su contexto y el objetivo final.

# 🚦 Cuándo usarla (Triggers)
Activa esta skill cuando:
- El usuario pida explícitamente realizar [acción específica].
- Te enfrentes a un error relacionado con [tecnología].
- Tengas que configurar [herramienta].

# 📋 Prerrequisitos (Pre-flight checks)
Antes de empezar a escribir código o modificar nada, verifica lo siguiente:
1. Comprueba que el archivo de configuración `X` existe (usa la herramienta de lectura).
2. Verifica que las credenciales no están hardcodeadas.
3. Asegúrate de que el servidor MCP de [Herramienta] está activo si lo necesitas.

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)
Sigue estos pasos EXACTAMENTE en este orden. No te saltes ninguno.

## Paso 1: Investigación (Discovery)
- Busca si el componente/archivo ya existe usando herramientas de búsqueda (ej. `grep_search` o `find_by_name`).
- Analiza las dependencias actuales del proyecto.

## Paso 2: Ejecución (Implementation)
- Escribe el código utilizando el patrón de diseño [Patrón].
- Si creas un archivo, asegúrate de añadir la cabecera estándar del proyecto.

## Paso 3: Validación (Verification)
- Antes de dar la tarea por finalizada, ejecuta los tests o el comando de compilación (ej. `npm run build` o `docker build`).
- Si falla, corrige el error de forma autónoma antes de avisar al usuario.

# 🛑 Reglas y Restricciones (Anti-patrones)
- **NUNCA** uses la librería `X`, usa siempre `Y`.
- **SIEMPRE** maneja los errores con un bloque `try/catch`.
- **NUNCA** hagas un `chmod 777` en los scripts bash.

# 💡 Ejemplos (Opcional)
```typescript
// Ejemplo de cómo debe lucir el código generado
export const miFuncion = () => {
  // Lógica estándar
};
```
