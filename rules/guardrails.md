# Reglas de Seguridad y Control de Versiones (Guardrails)

Estas reglas actúan como la "Constitución" del agente y deben ser respetadas incondicionalmente en todas las tareas e interacciones de este proyecto.

## 1. Operaciones de Git (Consentimiento Explícito)
- **Bloqueo de Commit/Push:** NUNCA ejecutes `git commit` ni `git push` de forma autónoma. 
- **Flujo de Trabajo:** Puedes modificar archivos y, si se te pide, añadirlos al *staging area* (`git add`), pero **siempre** debes detenerte y pedir confirmación explícita al usuario antes de registrar el commit en la historia.
- **Formato:** Cuando el usuario autorice realizar el commit, los mensajes deben seguir obligatoriamente el estándar **Conventional Commits** (ej: `feat: añade reglas de seguridad`, `fix: corrige error en pipeline`, `chore: actualiza dependencias`).
- **Prohibido reescribir historia publicada:** NUNCA ejecutes `git push --force` ni `git push --force-with-lease` sobre `main`, `master` ni ramas compartidas. Si fuese imprescindible, exige confirmación explícita y advierte del riesgo.
- **Operaciones destructivas de Git:** Pide confirmación antes de `git reset --hard`, `git clean -fd` o cualquier `rebase` que pueda descartar trabajo sin commitear.

## 2. Prevención de Fugas de Datos (Data Loss/Leak Prevention)
- **Cero Secretos:** NUNCA escribas contraseñas reales, tokens de API, JWTs, claves privadas ni cadenas de conexión con credenciales en el código fuente (ni siquiera en comentarios como ejemplos temporales).
- **Gestión de Entorno:** Utiliza siempre variables de entorno genéricas (ej. `process.env.DB_PASSWORD`) o marcadores de posición evidentes (ej. `<TU_API_KEY_AQUI>`).
- **Operaciones Destructivas:** Pide siempre confirmación explícita antes de ejecutar comandos que borren bases de datos, eliminen recursos en la nube, hagan `rm -rf` en directorios críticos o destruyan datos de Docker (ej. `docker system prune`, `docker volume rm`, `docker rmi`).

## 3. Protección Automatizada (Recomendado)
- **Escaneo de secretos:** instala un *hook* de pre-commit con [gitleaks](https://github.com/gitleaks/gitleaks) para bloquear credenciales **antes** de que entren en el histórico:

  ```yaml
  # .pre-commit-config.yaml
  repos:
    - repo: https://github.com/gitleaks/gitleaks
      rev: <ULTIMA_RELEASE>   # consulta la última versión publicada
      hooks:
        - id: gitleaks
  ```
- **`.gitignore` preventivo:** asegúrate de que `.env`, `*.pem`, `*.key`, `*.p12` y similares nunca se versionan; si un secreto llegó a subirse, considera la clave comprometida y **rótala** inmediatamente.
