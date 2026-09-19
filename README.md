# Mi Entorno Agéntico 🤖

Este repositorio es un **"kit de supervivencia agéntico"** diseñado por y para perfiles DevOps/FullStack. Es independiente del framework o IDE (Antigravity, Claude Code, Cursor, GitHub Copilot) y sirve para centralizar y estandarizar el comportamiento de la Inteligencia Artificial.

## 🏗️ Arquitectura del Kit

### 1. Rules (El Sistema Nervioso y las Leyes)
Políticas estrictas y marcos de trabajo que el agente debe obedecer el 100% del tiempo.
- [`rules/guardrails.md`](./rules/guardrails.md): Reglas de "Cero Trust". Prohíbe hacer commits/push de forma autónoma sin permiso explícito y blinda el código contra la fuga de secretos o credenciales.
- [`rules/master-workflow.md`](./rules/master-workflow.md): **El núcleo del sistema.** Implementa el ciclo de vida de desarrollo de software (SDLC) basado en el pipeline de Addy Osmani (`/spec -> /plan -> /build -> /test -> /review -> /ship`). Impone un *Definition of Done (DoD)* estricto: exige documentación inline (JSDoc), impone un 80% de cobertura en testing, y obliga a la actualización de este propio README y manuales al finalizar cada tarea.

### 2. Skills (Recetarios / Procedimientos Operativos)
Workflows bajo demanda utilizando el patrón de *progressive disclosure* para ahorrar contexto.
- [`skills/plantilla-base/SKILL.md`](./skills/plantilla-base/SKILL.md): Molde maestro estructurado para crear nuevas skills.
- [`skills/html-semantics-and-a11y/SKILL.md`](./skills/html-semantics-and-a11y/SKILL.md): Fuerza al agente a comportarse como un Frontend Senior, exigiendo HTML5 semántico y estándares estrictos de accesibilidad.
- [`skills/ux-ui-design-principles/SKILL.md`](./skills/ux-ui-design-principles/SKILL.md): Instruye a la IA en principios de diseño visual, carga cognitiva, espaciado (regla de los 8px) y metodologías estrictas para la correcta visualización de datos en Dashboards.

### 3. MCP (Model Context Protocol)
- [`mcp-config/mcp_servers.json`](./mcp-config/mcp_servers.json): Configuración preparada con los conectores externos más útiles para dar contexto al agente (Filesystem acotado, comandos de Git, inspección de bases de datos Postgres y Puppeteer para testing visual).

---

## 🚀 Cómo inyectar esto en tus proyectos

La mejor arquitectura para usar este entorno en tus proyectos es importarlo como un **submódulo de Git**. De esta forma, si actualizas las reglas globales, todos tus proyectos heredarán la actualización.

### Paso 1: Añadir el submódulo
En la raíz del proyecto destino (tu proyecto de Angular, Node, etc.), ejecuta:
```bash
git submodule add https://github.com/LafuenteColoradoJose/mi-entorno-agentico .agentic-base
```

### Paso 2: Crear el "Archivo Puntero"
Crea el archivo de configuración base de tu agente en la raíz de tu proyecto destino (ej. `.cursorrules`, `.clauderc` o `AGENTS.md`) con este contenido exacto:

```markdown
# Instrucciones Globales del Agente
Eres un ingeniero de software autónomo. Tu comportamiento, leyes operativas y estándares de calidad están definidos de forma externa.
Antes de ejecutar cualquier tarea o escribir código, ESTÁS OBLIGADO a leer, asimilar y acatar:
1. Reglas de Seguridad y Git: `./.agentic-base/rules/guardrails.md`
2. Flujo de Trabajo y DoD: `./.agentic-base/rules/master-workflow.md`

Tus procedimientos estándar (SOPs) y estándares de código residen en `./.agentic-base/skills/`. Utiliza tu herramienta de lectura para consultarlos según requiera el contexto de la tarea.
```
