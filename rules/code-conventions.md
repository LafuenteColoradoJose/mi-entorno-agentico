# 🧱 Convenciones de Código

> **Ámbito:** obligatoria en todos los proyectos (base genérica). Si un proyecto define
> sus propias convenciones en su `AGENTS.md`, **prevalece el proyecto**
> (prioridad: Guardrails > proyecto > base).

## 1. Principio rector

> El código se lee muchas más veces de las que se escribe. Optimiza para **claridad**,
> no para brevedad.

- **Consistencia > preferencia personal** dentro de un proyecto.
- **La herramienta manda**: si hay formateador, el estilo no se discute a mano.

## 2. Idioma

| Qué | Idioma | Motivo |
|---|---|---|
| Identificadores (variables, funciones, clases, ficheros) | **Inglés** | *Lingua franca* del código, las librerías y los modelos |
| Nombres de tests y fixtures | **Inglés** | Coherencia con el código de producción |
| Comentarios, docstrings y documentación | **Idioma del equipo** (ES) | Los leen personas, no el compilador |
| Mensajes de UI | **Idioma del usuario final** | Es producto, no código |
| Commits | **Tipo en inglés + descripción en español** | `feat: añade login` |
| Términos de dominio oficiales | Se mantienen | Nombres legales o de negocio |

> ⚠️ No mezcles idiomas en un identificador (`getUsuario`, `user_name_es`). Elige uno.

## 3. Nomenclatura por constructo

| Constructo | Convención | Ejemplo |
|---|---|---|
| Variable / función | camelCase (JS/TS, Java, C#) · snake_case (Python, Rust) | `getUserById` · `get_user_by_id` |
| Clase / tipo / interfaz | PascalCase | `UserRepository` |
| Constante | UPPER_SNAKE_CASE | `MAX_RETRIES` |
| Archivo | kebab-case (o estándar del lenguaje) | `user-repository.ts` |
| Carpeta | kebab-case | `user-management/` |
| Booleano | prefijo `is/has/can/should` | `isActive`, `hasAccess` |
| Evento | pasado | `userCreated` |
| Tabla / columna SQL | snake_case (tabla en plural) | `users`, `created_at` |
| Variable de entorno | UPPER_SNAKE_CASE | `DATABASE_URL` |

*(Si tu lenguaje no aparece, aplica su guía oficial: PEP 8, Effective Go, etc.)*

## 4. Reglas de claridad (universales)

| ✅ Haz | ❌ Evita |
|---|---|
| Nombres descriptivos y pronunciables | Abreviaturas crípticas (`usr`, `cnt`) |
| Un concepto = una palabra | Mezclar `get` / `fetch` / `retrieve` |
| Booleanos en positivo | `notDisabled`, `isNotReady` |
| Constantes con nombre | Números mágicos (`if (x > 86400)`) |
| Una responsabilidad por función | Funciones de 200 líneas |
| Verbos para funciones (`calculateTotal`) | Sustantivos ambiguos (`total`) |
| Siglas aceptadas: `id`, `url`, `api`, `http` | Hungarian notation (`strName`) |

## 5. Formato

No se formatea a mano: se usa el **formateador canónico** del lenguaje, con su config versionada.

| Lenguaje | Formateador / Linter |
|---|---|
| JS / TS | Prettier + ESLint |
| Python | Ruff (o Black + Ruff) |
| Go | `gofmt` / `go vet` |
| Rust | `rustfmt` / Clippy |
| Java / C# | Spotless / `dotnet format` |
| SQL | `sqlfluff` |

- Config en el repo (`.prettierrc`, `pyproject.toml`, `.editorconfig`...).
- **Nadie** discute formato en un PR: lo decide la herramienta.
- `.editorconfig` para lo común (indentación, fin de línea, UTF-8).

## 6. Archivos y estructura

- **Un archivo, una responsabilidad.**
- Tests junto al código (`*.test.ts`, `test_*.py`) o en `tests/` según el lenguaje.
- Carpetas en kebab-case; prohibido `misc/` y `utils/` como cajón desastre.
- Sin código comentado: si no se usa, se borra (para eso está Git).

## 7. Comentarios y documentación

| Tipo | Regla |
|---|---|
| Comentario | Explica **por qué**, no **qué** |
| Docstring / JSDoc | Obligatorio en APIs públicas |
| TODO | `// TODO(autor): motivo y condición de cierre` |
| Obviedades | Prohibidas (`// incrementa i`) |

## 8. Errores, logs y secretos

- Errores **tipados** o con código, no strings sueltos.
- Logs **estructurados**, con niveles coherentes.
- **Nunca** secretos ni datos personales en logs (ver [`guardrails.md`](./guardrails.md)).
- `catch` vacío prohibido: no tragarse excepciones.

## 9. Tests

| Aspecto | Convención |
|---|---|
| Nombre | `should <behavior> when <condition>` (**inglés**) |
| Fixtures y datos de prueba | **Inglés**, con nombres claros |
| Estructura | Arrange · Act · Assert |
| Granularidad | Un concepto por test |
| Números mágicos | Prohibidos: usa constantes o fixtures con nombre |

## 10. Checklist antes de dar por terminado

- [ ] Identificadores en inglés y coherentes.
- [ ] Tests y fixtures con nombres en inglés.
- [ ] Comentarios/docstrings en el idioma del equipo.
- [ ] Formateador y linter pasan sin errores.
- [ ] Sin números mágicos ni código comentado.
- [ ] Sin secretos en código ni logs.

## Relación con otras reglas

- [`master-workflow.md`](./master-workflow.md): fases y *Definition of Done*.
- [`guardrails.md`](./guardrails.md): seguridad y secretos.
- Convenciones **de un proyecto**: en su `AGENTS.md` (prevalecen sobre esta base).
