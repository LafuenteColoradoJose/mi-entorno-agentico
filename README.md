# Mi Entorno Agéntico 🤖

Este repositorio es un **"kit de supervivencia agéntico"** diseñado por y para perfiles DevOps/FullStack. Es independiente del framework o IDE (Antigravity, Claude Code, Cursor, GitHub Copilot) y sirve para centralizar y estandarizar el comportamiento de la Inteligencia Artificial.

<a id="generico-vs-especifico"></a>

## 🧭 Cómo está pensado esto: genérico vs. específico

Antes de usar el kit conviene entender su **filosofía de diseño** y los tres conceptos que maneja.

### ¿Qué es una Rule, una Skill y un MCP?

- **Rule (Regla):** una ley **siempre activa** y de obligado cumplimiento. No se "activa": se acata en el 100% de las tareas (ej. seguridad, flujo de trabajo).
- **Skill (Habilidad):** un **procedimiento bajo demanda**. El agente la activa solo cuando la tarea encaja con su `description`, ahorrando contexto (patrón *progressive disclosure*).
- **MCP (Model Context Protocol):** un **conector** a una herramienta o servicio externo (sistema de archivos, Git, bases de datos, un navegador...). Le da al agente acceso a cosas que no son texto.

Separarlos no es capricho: cada pieza tiene un alcance y un ciclo de vida distintos. Mezclarlas obligaría a cargar siempre contexto que no necesitas.

### El modelo: una base universal + especialización por proyecto

```
        ┌───────────────────────────────────────────────┐
        │   BASE GENÉRICA (este repo, como submódulo)    │
        │   Rules:  guardrails, SDLC                     │
        │   Skills: a11y, UX/UI                          │
        │   MCP:    filesystem, git, navegador           │
        └───────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
   Proyecto Angular     Proyecto Nuxt      Proyecto PyTorch
   + skills/angular     + skills/nuxt      + skills/pytorch
   + MCP de Angular     + MCP de Nuxt      + MCP de BD vectorial
```

La base contiene **solo lo que aplica siempre, sin importar la tecnología**. Todo lo que depende de una tecnología concreta vive **en el proyecto**, no aquí. Así la base se mantiene pequeña y universal, y no consume contexto de más.

### ¿Dónde va cada cosa?

| Pieza | En la base (genérico) | Por proyecto (específico) | Dónde vive lo específico |
|---|---|---|---|
| **Rules** | guardrails, SDLC | reglas de dominio ("usar siempre la API X") | `AGENTS.md` del proyecto |
| **Skills** | a11y, UX/UI | `angular`, `nuxt`, `pytorch`, `postgres-avanzado` | carpeta de skills de tu herramienta (ver [portabilidad](#portabilidad)) |
| **MCP** | filesystem, git, navegador | BD, MCP de Nuxt/Figma/Sentry, k8s | config MCP del proyecto |

### La regla de decisión

> **¿Aplica a TODOS mis proyectos sin excepción?** → va en la **base**.
> **¿Solo a los que usan X tecnología?** → va en el **proyecto**.

### Ejemplos según tu perfil

- 🕸️ **Web / FullStack:** base = a11y + UX/UI. Por proyecto: skill `angular` o `nuxt`, MCP de Nuxt.
- 🖧 **SysAdmin / Redes:** base = guardrails. Por proyecto: skills de `kubernetes`/`nginx`, MCP de Kubernetes.
- 🧠 **IA / BigData:** por proyecto: skill `pytorch`, MCP de base de datos vectorial.

### Cómo añadir algo específico a un proyecto (mini-tutorial)

1. **Skill nueva:** copia [`templates/SKILL.template.md`](./templates/SKILL.template.md) a la carpeta de skills de tu herramienta (`.agents/skills/<nombre>/SKILL.md`, `.claude/skills/...`, `.opencode/skills/...`) y rellénalo.
2. **MCP nuevo:** añade su entrada en la configuración MCP de tu proyecto (ver el patrón en [`mcp-config/README.md`](./mcp-config/README.md)).
3. **Regla nueva:** añádela al `AGENTS.md` de tu proyecto.

Y listo: la base sigue genérica y cada proyecto se especializa sin tocar el kit común.

## 🏗️ Arquitectura del Kit

### 1. Rules (El Sistema Nervioso y las Leyes)
Políticas estrictas y marcos de trabajo que el agente debe obedecer el 100% del tiempo.
- [`rules/guardrails.md`](./rules/guardrails.md): Reglas de "Cero Trust". Prohíbe hacer commits/push de forma autónoma sin permiso explícito y blinda el código contra la fuga de secretos o credenciales.
- [`rules/master-workflow.md`](./rules/master-workflow.md): **El núcleo del sistema.** Implementa el ciclo de vida de desarrollo de software (SDLC) basado en el pipeline de Addy Osmani (`/spec -> /plan -> /build -> /test -> /review -> /ship`). Impone un *Definition of Done (DoD)* estricto: exige documentación inline (JSDoc), impone un 80% de cobertura en testing, y obliga a la actualización de este propio README y manuales al finalizar cada tarea.

### 2. Skills (Recetarios / Procedimientos Operativos)
Workflows bajo demanda utilizando el patrón de *progressive disclosure* para ahorrar contexto.
- [`templates/SKILL.template.md`](./templates/SKILL.template.md): Molde maestro estructurado para crear nuevas skills (vive fuera de `skills/` para que el agente no lo confunda con una skill real).
- [`skills/html-semantics-and-a11y/SKILL.md`](./skills/html-semantics-and-a11y/SKILL.md): Fuerza al agente a comportarse como un Frontend Senior, exigiendo HTML5 semántico y estándares estrictos de accesibilidad.
- [`skills/ux-ui-design-principles/SKILL.md`](./skills/ux-ui-design-principles/SKILL.md): Instruye a la IA en principios de diseño visual, carga cognitiva, espaciado (regla de los 8px), enfoques 100% Mobile-First (Responsive Design fluido) y metodologías estrictas para la correcta visualización de datos en Dashboards.

### 3. MCP (Model Context Protocol)
- [`mcp-config/mcp_servers.example.json`](./mcp-config/mcp_servers.example.json): Plantilla con conectores genéricos (Filesystem acotado, Git, Playwright y Chrome DevTools). Los conectores específicos como la base de datos se añaden por proyecto. Ver [`mcp-config/README.md`](./mcp-config/README.md) para sustituir los marcadores `${...}` sin hardcodear credenciales.

<a id="portabilidad"></a>

## 🌐 Portabilidad: funciona con cualquier agente

Este kit **no depende de ningún IDE ni proveedor**. Se apoya en dos **estándares abiertos**, así que sirve igual para OpenAI, Anthropic o Google:

- **Skills = [Agent Skills](https://agentskills.io/home)** — estándar abierto creado por Anthropic y leído por 30+ herramientas (Claude Code, OpenAI Codex, Cursor, Gemini CLI, Antigravity, OpenCode...). El mismo `SKILL.md` corre **sin cambios** en todas.
- **Rules = [AGENTS.md](https://agents.md/)** — estándar abierto (+60.000 proyectos, amparado por la Linux Foundation).

Lo único que cambia según la herramienta es **dónde se coloca** cada pieza:

| Herramienta | Archivo/carpeta de reglas | Carpeta de skills |
|---|---|---|
| **Cursor** | `AGENTS.md` (+ `.cursor/rules/*.mdc`) | `.agents/skills/` |
| **OpenAI Codex** | `AGENTS.md` | (estándar) |
| **Claude Code** (Anthropic) | `CLAUDE.md` → *bridge* | `.claude/skills/` |
| **Google Antigravity** | `.agents/rules/` | `.agents/skills/` |
| **GitHub Copilot** | `AGENTS.md` / `.github/copilot-instructions.md` | — |
| **OpenCode** | `AGENTS.md` | `.opencode/skills/` |

> ℹ️ `.cursorrules` y `.clauderc` son **legacy/inexistentes**: hoy se usa `AGENTS.md` y `CLAUDE.md`.

**Truco del archivo único para todos:** usa **`AGENTS.md`** como fuente de verdad y crea *bridges* de una línea para las herramientas que esperan otro nombre:

```markdown
<!-- CLAUDE.md -->
@AGENTS.md
```

Así cubres a la vez Codex, Cursor, Copilot y OpenCode, y a Claude Code vía el bridge `CLAUDE.md` (o con `ln -s AGENTS.md CLAUDE.md`).

---

## 🚀 Cómo inyectar esto en tus proyectos

La mejor arquitectura para usar este entorno en tus proyectos es importarlo como un **submódulo de Git**. De esta forma, si actualizas las reglas globales, todos tus proyectos heredarán la actualización.

### Paso 1: Añadir el submódulo
En la raíz del proyecto destino (tu proyecto de Angular, Node, etc.), ejecuta:
```bash
git submodule add https://github.com/LafuenteColoradoJose/mi-entorno-agentico .agentic-base
```

### Paso 2: Crear el "Archivo Puntero"
Crea el archivo de instrucciones del agente en la raíz de tu proyecto. El **estándar es [`AGENTS.md`](https://agents.md/)** (lo leen Cursor, Codex, Copilot, OpenCode...). Para las herramientas que esperan otro nombre, crea un *bridge* de una línea hacia él (ver [portabilidad](#portabilidad)). Contenido recomendado de `AGENTS.md`:

```markdown
# Instrucciones Globales del Agente
Eres un ingeniero de software autónomo. Tu comportamiento, leyes operativas y estándares de calidad están definidos de forma externa.
Antes de ejecutar cualquier tarea o escribir código, ESTÁS OBLIGADO a leer, asimilar y acatar:
1. Reglas de Seguridad y Git: `./.agentic-base/rules/guardrails.md`
2. Flujo de Trabajo y DoD: `./.agentic-base/rules/master-workflow.md`

Tus procedimientos estándar (SOPs) y estándares de código residen en `./.agentic-base/skills/`. Utiliza tu herramienta de lectura para consultarlos según requiera el contexto de la tarea.
```

> **Prioridad ante conflicto:** Guardrails (seguridad) > reglas del proyecto > base genérica.

### Paso 3: Actualizar el submódulo (Mantenimiento)
Dado que las *Rules* y *Skills* de este repositorio genérico irán evolucionando, puedes traerte las últimas novedades a tus proyectos locales simplemente ejecutando este comando desde la raíz de tu proyecto destino (por ejemplo, dentro de `AEMET_Visualizer_Pro`):

```bash
git submodule update --remote --merge
```
