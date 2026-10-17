# Changelog

Todos los cambios notables de este proyecto se documentan en este archivo.
El formato sigue [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y el proyecto se adhiere al [Versionado Semántico](https://semver.org/lang/es/).

## [No publicado]

## [1.1.0] - 2026-10-17

### Añadido
- Sección **«Portabilidad»** en el README: estándares abiertos (Agent Skills, `AGENTS.md`) y
  tabla de rutas por herramienta (Cursor, Codex, Claude Code, Antigravity, Copilot, OpenCode).
- Sección **«Genérico vs. específico»**: modelo de capas, tabla "dónde va cada cosa", regla de
  decisión y mini-tutorial.
- Conector MCP **`chrome-devtools`** para depuración en navegador (console, network, performance).
- `CHANGELOG.md` y **versionado semántico** con tags.
- README de puntero en `rules/` y `skills/`, y guía en `mcp-config/README.md`.

### Cambios
- `mcp-config/mcp_servers.json` → **`mcp_servers.example.json`** (plantilla, sin credenciales).
- **Guardrails ampliados:** prohibición de reescribir historia publicada (`push --force`) y de
  operaciones destructivas de Git/Docker, más recomendación de escaneo de secretos con gitleaks.
- La **base ya no incluye un conector de BD**: se añade por proyecto (DBHub o `mongodb-mcp-server`).
- Plantilla de skills reubicada de `skills/plantilla-base/` a `templates/SKILL.template.md`.

### Corregido
- Servidores MCP **archivados** sustituidos (puppeteer→playwright, git→`mcp-server-git`).
- Frontmatter **YAML roto** de la plantilla de skills (el `": "` en la `description`).
- Enlaces y referencias obsoletas del README (`.cursorrules`/`.clauderc` → `AGENTS.md`/`CLAUDE.md`).

## [1.0.0] - 2026-09-19

### Añadido
- Arquitectura base del kit: `rules/` (guardrails, master-workflow), `skills/`
  (html-semantics-and-a11y, ux-ui-design-principles), plantilla de skills y `mcp-config/`.
- README con instrucciones de uso como **submódulo de Git**.
