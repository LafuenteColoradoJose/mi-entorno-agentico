---
name: security-and-hardening
description: Revisa y endurece la seguridad de una aplicación según el riesgo real; actívala al manejar entradas, autenticación, datos, integraciones externas o dependencias, o antes de publicar.
---

<!--
PARA QUÉ SIRVE
Guía a un agente para identificar riesgos de seguridad en un cambio concreto y reducirlos
con evidencia, sin convertir la revisión en una auditoría total ni prometer invulnerabilidad.
Es agnóstica del lenguaje, framework, nube y herramienta.

PUNTO DE PARTIDA PARA OTROS AGENTES
Puedes mejorar esta skill manteniendo el enfoque en riesgo y evidencia, y la separación
entre lo confirmado y lo inferido. No fijes herramientas, versiones ni marcos de
cumplimiento: se toman de las reglas y del entorno del proyecto. Las prohibiciones
permanentes (secretos, git, operaciones destructivas) viven en ../../rules/guardrails.md;
esta skill no las repite.
-->

# 🎯 Propósito

Ayudar a encontrar y reducir riesgos de seguridad **en el cambio que se está haciendo**, con
un alcance proporcionado al riesgo. La revisión debe responder a preguntas concretas: qué
datos toca este cambio, quién puede abusar de él y qué control lo impide.

Esta skill es el **procedimiento**. Las **prohibiciones siempre activas** están en
[`../../rules/guardrails.md`](../../rules/guardrails.md). Los umbrales y el flujo, en
[`../../rules/master-workflow.md`](../../rules/master-workflow.md). Esta skill no impone
lenguajes, herramientas ni marcos de cumplimiento (ISO, GDPR, PCI): si hay datos personales
o requisitos legales, señálalo y remite a la normativa aplicable sin sustituir asesoría.

# 🚦 Cuándo usarla (Triggers)

Actívala cuando el cambio:

- recibe **entradas** nuevas o modificadas (formularios, APIs, ficheros, colas, CLI, webhooks);
- toca **autenticación, autorización, sesiones, permisos o multi-tenant**;
- **almacena, muestra o exporta** datos personales o sensibles;
- se **integra** con un servicio externo o una API de terceros;
- añade **dependencias** o cambia configuración sensible (CORS, cabeceras, TLS, permisos);
- se prepara para **publicar** o llega tras un **incidente**;
- el usuario pide una **revisión de seguridad** explícita.

No la actives para cambios que no tocan superficie de ataque (textos, estilos, documentación)
ni para repetir auditorías ya hechas sin cambios relevantes.

# 📋 Prerrequisitos (Pre-flight checks)

Antes de revisar, verifica:

1. Lee [`../../rules/guardrails.md`](../../rules/guardrails.md) y las instrucciones del proyecto (`AGENTS.md`).
2. Identifica qué **datos** maneja el cambio y su sensibilidad (público, interno, personal, secreto).
3. Localiza las **protecciones que ya existen**: middleware de autenticación, validación,
   gestión de secretos, cabeceras, y las herramientas de seguridad que el proyecto ya use.
4. Acota el **alcance** con el usuario: un cambio, un módulo o la aplicación completa.
5. No ejecutes escaneos o pruebas de intrusión contra sistemas de terceros ni con datos
   reales sin autorización explícita.

# 🧭 Principios

1. **Riesgo primero.** Revisa lo que este cambio puede romper, no el catálogo entero.
2. **Evidencia.** Cada hallazgo debe citar ruta, símbolo o configuración y un escenario de
   abuso plausible. Sin eso, es una sospecha (y se etiqueta como tal).
3. **Defensa en profundidad.** No confíes en una sola capa: cliente + servidor + datos.
4. **Privilegio mínimo.** Cuentas, tokens y permisos con lo estrictamente necesario.
5. **Fallar cerrado.** Ante un error o una duda de autorización, denegar por defecto.
6. **No filtrar.** Errores genéricos al usuario; logs internos sin secretos ni datos personales.
7. **Honestidad.** "No encontré evidencia de X" no significa "es seguro".

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)

## Paso 1: Identificar activos y límites de confianza

- Qué datos entran, qué se transforma, dónde se guarda y qué sale.
- Qué cruza un límite: usuario → API → base de datos → servicio externo.
- Qué actores intervienen y con qué privilegios (anónimo, usuario, administrador, servicio).
- Marca explícitamente los datos personales o sensibles que aparezcan.

## Paso 2: Modelar amenazas del cambio

Para cada entrada y cada límite, pregunta qué podría hacer un atacante. Puedes usar las
categorías de STRIDE como guía (suplantación, manipulación, repudio, revelación,
denegación, elevación), sin convertirlas en una lista rígida.

Descarta lo que no aplica al alcance y **dilo**. Un modelo pequeño y honesto vale más que
una tabla exhaustiva sin evidencia.

## Paso 3: Revisar las categorías aplicables (OWASP Top 10)

Usa el [OWASP Top 10](https://owasp.org/Top10/) como **marco de categorías**, no como
checklist obligatorio. Revisa solo las que apliquen al cambio:

| Categoría | Qué mirar |
|---|---|
| **Control de acceso roto** | Autorización en servidor, IDOR, roles, aislamiento entre inquilinos. |
| **Fallos criptográficos** | Secretos fuera del repo, algoritmos actuales, TLS, hash de contraseñas con sal y coste. |
| **Inyección** | SQL/NoSQL, comandos, plantillas; parametrización y escape según el contexto. |
| **Diseño inseguro** | Flujos sin límites, sin *rate limiting*, sin confirmación en operaciones sensibles. |
| **Configuración incorrecta** | CORS, cabeceras, modo debug, puertos, permisos por defecto. |
| **Componentes vulnerables** | Dependencias sin mantenimiento o desactualizadas, *lockfiles*. |
| **Fallos de identificación y autenticación** | Sesiones, fijación de sesión, recuperación de contraseña, MFA. |
| **Fallos de integridad** | Deserialización, actualizaciones sin verificar, datos sin validar. |
| **Fallos de registro y monitorización** | Ausencia de auditoría de eventos de seguridad; logs con datos sensibles. |
| **SSRF** | URLs controladas por el usuario; *allowlist* de destinos. |

## Paso 4: Verificar en el código y la configuración

- **Validación en servidor**, nunca solo en cliente. Prefiere *allowlist* a *blocklist*.
- **Codificación por contexto**: HTML, SQL, shell, URL y JSON no se escapan igual.
- **Autorización en cada operación**, no solo en la interfaz.
- **Secretos** desde entorno o gestor; nunca en el repo ni en logs.
- **Sesiones y cookies**: `HttpOnly`, `Secure`, `SameSite`, caducidad razonable.
- **Subida de ficheros**: tipo real, tamaño, nombre y almacenamiento fuera del *webroot*.
- **Rate limiting** en login, registro y recuperación de cuenta.
- **Dependencias**: audita con la herramienta que ya use el proyecto; revisa el *lockfile*;
  no añadas paquetes sin necesidad.
- **Configuración**: CORS explícito, cabeceras de seguridad, TLS, permisos mínimos de base
  de datos y servicios.

## Paso 5: Comprobar con pruebas

Añade o actualiza pruebas que **demuestren el control**, no solo el camino feliz. Por
ejemplo: un usuario no puede leer el recurso de otro (403), una entrada inválida se rechaza,
un token caducado no se acepta.

Sigue [`../testing-and-quality/SKILL.md`](../testing-and-quality/SKILL.md) para elegir el
nivel y ejecutar solo lo que el entorno permita. Si una comprobación no puede ejecutarse,
identifícala como pendiente; no la des por superada.

## Paso 6: Informar el resultado

Presenta cada hallazgo con:

- **Severidad** (crítica, alta, media, baja, informativa).
- **Ubicación** (ruta, símbolo, línea o configuración).
- **Escenario** de abuso e impacto.
- **Recomendación** concreta y, si procede, el cambio propuesto.
- **Evidencia**: qué lo confirma y qué queda como sospecha.

Cierra con lo que **no** se revisó y el **riesgo residual**. No incluyas secretos reales:
redáctalos.

# 💡 Ejemplos

## Nuevo endpoint con un identificador en la URL

Comprueba que la autorización se valida en servidor y que un usuario no puede pedir el
recurso de otro (IDOR). Añade una prueba que espere 403 para el caso ajeno.

## Formulario de login

Revisa *rate limiting*, mensajes de error genéricos, hash de contraseñas con coste adecuado,
cookies `HttpOnly`/`Secure`/`SameSite` y que la sesión se renueve al autenticarse.

## Dependencia nueva

Justifica su necesidad, revisa que esté mantenida y con versiones fijadas, y ejecuta la
auditoría que ya tenga el proyecto. Si no hay herramienta, propón opciones sin imponer una.

# 🛑 Reglas y Restricciones (Anti-patrones)

- **NUNCA** afirmes que algo "es seguro" o "está blindado": di qué comprobaste y qué no.
- **NUNCA** inventes CVEs, exploits ni vectores sin evidencia.
- **NUNCA** ejecutes escaneos o pruebas de intrusión contra sistemas de terceros ni con
  datos reales sin autorización explícita.
- **NUNCA** incluyas secretos reales en informes, incidencias o pruebas; redáctalos.
- **NUNCA** desactives una protección (CSRF, CORS, validación, TLS) para "que funcione".
- **NUNCA** añadas dependencias de seguridad sin necesidad concreta y autorización.
- **SIEMPRE** enlaza cada hallazgo con su evidencia y distingue confirmado de inferido.
- **SIEMPRE** respeta las prohibiciones de [`../../rules/guardrails.md`](../../rules/guardrails.md).
