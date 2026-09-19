# Mi Entorno Agéntico

Este repositorio sirve como un **"kit de supervivencia agéntico"**, independiente del framework o IDE utilizado (Antigravity, Claude Code, Cursor, GitHub Copilot, etc.). Está diseñado para centralizar y estandarizar nuestras configuraciones de Inteligencia Artificial para el desarrollo de software y operaciones (DevOps).

## Capas de la Arquitectura

1. **Rules (El "Qué No" / Guardia):** 
   Guardrails, restricciones y estilo global. Son políticas estrictas de seguridad y estándares que están activas el 100% del tiempo.
2. **Skills (El "Cómo" / Orquestador):** 
   Recetarios y workflows paso a paso (SOPs). Usan el patrón de *progressive disclosure* para que el agente solo las lea en profundidad si la tarea lo requiere.
3. **MCP (El "Qué" / Conectividad):** 
   Model Context Protocol. Conectores universales a herramientas y fuentes de datos externas (APIs, bases de datos, sistemas de archivos, herramientas CLI).

## Estructura de Carpetas Propuesta

```text
/mi-entorno-agentico
├── /rules
│   ├── security.md           # Reglas de no volcar secretos
│   └── git-standards.md      # Conventional commits, flujos de ramas
├── /skills
│   ├── /docker-best-practices
│   │   └── SKILL.md          # Pasos para hacer un buen Dockerfile
│   └── /ci-cd-bootstrap
│       └── SKILL.md          # Pasos para crear un pipeline básico
└── /mcp-config
    └── mcp_servers.json      # Configuración de los servidores genéricos (bash, git, postgres)
```

## Roadmap / Próximos Pasos
- [ ] Crear nuestra primera Rule global de seguridad.
- [ ] Diseñar el esquema de un `SKILL.md` base.
- [ ] Configurar un servidor MCP esencial (ej. filesystem o git).
