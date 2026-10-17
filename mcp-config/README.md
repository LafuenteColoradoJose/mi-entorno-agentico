# 🔌 Configuración MCP

Los conectores de esta carpeta son **genéricos/universales** (sistema de archivos, Git,
navegador). Los **específicos de un proyecto** (base de datos, MCP de Nuxt, Figma, k8s...)
se añaden por proyecto — ver el [**README principal · genérico vs. específico**](../README.md#generico-vs-especifico).

`mcp_servers.example.json` es una **plantilla**. No contiene credenciales ni rutas
reales: usa marcadores `${...}` que debes sustituir (o exportar como variables de
entorno en tu cliente MCP) antes de usarla.

> Regla de oro (ver `../rules/guardrails.md`): **cero secretos en el repo**.
> Nunca escribas contraseñas, tokens ni cadenas de conexión reales en este archivo.

## Marcadores a sustituir

| Marcador             | Qué poner                                                |
|----------------------|----------------------------------------------------------|
| `${WORKSPACE_PATH}`  | Ruta absoluta al directorio de trabajo acotado           |
| `${REPOSITORY_PATH}` | Ruta absoluta al repositorio Git que quieras exponer      |

## Servidores incluidos

| Clave             | Paquete                         | Para qué sirve                          |
|-------------------|---------------------------------|-----------------------------------------|
| `filesystem`      | `@modelcontextprotocol/server-filesystem` | Lectura/escritura acotada a un workspace |
| `git`             | `mcp-server-git` (vía `uvx`)    | Estado, diffs, log, ramas y commits      |
| `playwright`      | `@playwright/mcp@latest`        | Testing visual / automatización de navegador |
| `chrome-devtools` | `chrome-devtools-mcp@latest`    | Depuración real en navegador (console, network, perf) |

> La **base de datos no va en la plantilla**: no todo proyecto tiene una, y el motor
> varía. Se añade por proyecto — ver la sección siguiente.

## ¿Playwright o Chrome DevTools?

Ambos son servidores de navegador y **pueden convivir**; sirven a propósitos distintos:

| Necesitas…                                              | Usa…             |
|---------------------------------------------------------|------------------|
| Automatizar acciones, generar tests E2E, auditar a11y   | `playwright`     |
| Ver errores de consola, network, trazas de performance  | `chrome-devtools`|
| Capturas / screencast para revisión visual              | Cualquiera       |

Si solo quieres uno, **Playwright** es más versátil para testing; **Chrome DevTools** gana
cuando necesitas *depurar* una app en ejecución.

## Bases de datos (se añaden por proyecto)

No incluimos ningún conector de BD en la plantilla porque no es universal. Cuando un
proyecto la necesite, copia el bloque que corresponda. **Nunca** pongas la cadena de
conexión literal: léela de una variable de entorno.

**SQL en general** (PostgreSQL, MySQL, **MariaDB**, SQL Server, Oracle, SQLite) — un solo
servidor, un solo *connection string*, gracias a [DBHub](https://github.com/bytebase/dbhub):

```json
"database": {
  "command": "npx",
  "args": ["-y", "@bytebase/dbhub@latest", "--transport", "stdio", "--dsn", "${DATABASE_URL}"]
}
```

**MongoDB** (NoSQL) — servidor oficial, con modo solo-lectura:

```json
"mongodb": {
  "command": "npx",
  "args": ["-y", "mongodb-mcp-server@latest", "${MONGODB_URI}", "--readOnly"]
}
```

## Cambios respecto a la versión anterior

Los antiguos `@modelcontextprotocol/server-git`, `server-postgres` y `server-puppeteer`
fueron **archivados/descontinuados** por Anthropic (2025) y el de Postgres tenía una
vulnerabilidad de SQL injection conocida. Se han sustituido por:

- Puppeteer → **Playwright MCP** (`@playwright/mcp`).
- Git → **`mcp-server-git`** oficial (Python, vía `uvx`).
- Postgres → **eliminado de la base**; se añade por proyecto con **DBHub** (multi-motor)
  o **`mongodb-mcp-server`** si es MongoDB.

## Notas de seguridad

- **Bases de datos:** si solo necesitas consultar, configúralas en modo read-only
  (DBHub: `readonly = true` en su TOML; MongoDB: flag `--readOnly`). Nunca expongas un
  conector con permiso de escritura salvo que lo necesites.
- **Playwright / Chrome DevTools:** ejecútalos con `--headless` en CI/entornos sin pantalla.
  Chrome DevTools admite además `--isolated` (perfil temporal), `--channel <stable|beta|dev>`
  y `--browserUrl` para conectarse a un Chrome ya en marcha.
- El servidor de **filesystem** debe apuntar solo al workspace, nunca a `/` ni a tu `$HOME`.
