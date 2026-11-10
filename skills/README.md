# 🧠 Skills

Las skills de esta carpeta son **genéricas**: aplican a cualquier proyecto, sin importar
la tecnología (accesibilidad, UX/UI...).

- El formato `SKILL.md` es el **estándar abierto [Agent Skills](https://agentskills.io/home)**,
  así que el **mismo archivo** funciona sin cambios en Claude Code, OpenAI Codex, Cursor,
  Gemini CLI, Antigravity, OpenCode...
- Las **skills específicas** (`angular`, `nuxt`, `pytorch`, `postgres-avanzado`...) se
  añaden **por proyecto**, en la carpeta de skills de tu herramienta, partiendo de
  [`templates/SKILL.template.md`](../templates/SKILL.template.md):
  `.agents/skills/` (Antigravity/Gemini) · `.claude/skills/` (Claude Code) · `.opencode/skills/` (OpenCode).

→ Ver la explicación completa en el [**README principal · genérico vs. específico**](../README.md#generico-vs-especifico)
y en [**portabilidad**](../README.md#portabilidad).

## Índice de skills

| Skill | Para qué |
|---|---|
| [`context-economy`](./context-economy/SKILL.md) | Navegar por el repo leyendo lo justo para ahorrar tokens. |
| [`architecture-visualization`](./architecture-visualization/SKILL.md) | Investigar un sistema y producir diagramas respaldados por evidencia. |
| [`html-semantics-and-a11y`](./html-semantics-and-a11y/SKILL.md) | HTML5 semántico y accesibilidad estricta. |
| [`ux-ui-design-principles`](./ux-ui-design-principles/SKILL.md) | Diseño visual, mobile-first y visualización de datos en dashboards. |
| [`shell-scripting-safe`](./shell-scripting-safe/SKILL.md) | Bash robusto y seguro. |
| [`docker-and-compose`](./docker-and-compose/SKILL.md) | Dockerfiles multi-stage y Compose para desarrollo. |
| [`python-environments`](./python-environments/SKILL.md) | `venv`, dependencias pineadas y reproducibilidad. |

La skill `architecture-visualization` tiene una plantilla complementaria:
[`templates/ARCHITECTURE-DIAGRAM.template.html`](../templates/ARCHITECTURE-DIAGRAM.template.html),
un HTML autónomo con SVG interactivo y sin bibliotecas externas.
