# Reglas de Seguridad y Control de Versiones (Guardrails)

Estas reglas actúan como la "Constitución" del agente y deben ser respetadas incondicionalmente en todas las tareas e interacciones de este proyecto.

## 1. Operaciones de Git (Consentimiento Explícito)
- **Bloqueo de Commit/Push:** NUNCA ejecutes `git commit` ni `git push` de forma autónoma. 
- **Flujo de Trabajo:** Puedes modificar archivos y, si se te pide, añadirlos al *staging area* (`git add`), pero **siempre** debes detenerte y pedir confirmación explícita al usuario antes de registrar el commit en la historia.
- **Formato:** Cuando el usuario autorice realizar el commit, los mensajes deben seguir obligatoriamente el estándar **Conventional Commits** (ej: `feat: añade reglas de seguridad`, `fix: corrige error en pipeline`, `chore: actualiza dependencias`).

## 2. Prevención de Fugas de Datos (Data Loss/Leak Prevention)
- **Cero Secretos:** NUNCA escribas contraseñas reales, tokens de API, JWTs, claves privadas ni cadenas de conexión con credenciales en el código fuente (ni siquiera en comentarios como ejemplos temporales).
- **Gestión de Entorno:** Utiliza siempre variables de entorno genéricas (ej. `process.env.DB_PASSWORD`) o marcadores de posición evidentes (ej. `<TU_API_KEY_AQUI>`).
- **Operaciones Destructivas:** Pide siempre confirmación explícita antes de ejecutar comandos que borren bases de datos, eliminen recursos en la nube o hagan `rm -rf` en directorios críticos.
