---
name: testing-and-quality
description: Diseña, escribe y ejecuta pruebas adecuadas al riesgo y al comportamiento esperado; actívala al añadir funciones, corregir errores, refactorizar o investigar fallos en cualquier stack.
---

<!--
PARA QUÉ SIRVE
Guía a un agente desde entender qué debe probarse hasta ejecutar las comprobaciones
pertinentes y explicar qué demuestran. Es agnóstica del lenguaje, framework y proveedor.

PUNTO DE PARTIDA PARA OTROS AGENTES
Puedes mejorar esta skill manteniendo la adaptación al proyecto, el foco en comportamiento
y riesgo, y la separación entre evidencia y suposiciones. No fijes herramientas ni umbrales
universales: se consultan las instrucciones y convenciones del proyecto.
-->

# 🎯 Propósito

Ayudar a comprobar que un cambio cumple el comportamiento esperado y no rompe flujos
relacionados. La estrategia debe ser suficiente para reducir riesgos, mantenerse legible
y aprovechar las herramientas que el proyecto ya usa.

Esta skill no impone lenguajes, frameworks, comandos, porcentajes de cobertura ni una
pirámide de pruebas universal. Las reglas del proyecto y
[`../../rules/master-workflow.md`](../../rules/master-workflow.md) determinan el flujo y
los umbrales aplicables.

# 🚦 Cuándo usarla (Triggers)

Actívala cuando el usuario pida:

- añadir o corregir pruebas;
- implementar una función, corregir un error o refactorizar código;
- revisar si un cambio está suficientemente verificado;
- investigar una prueba que falla, es lenta o parece inestable;
- diseñar una estrategia de pruebas para un comportamiento o flujo.

No añadas pruebas por rutina a tareas que no cambian comportamiento ni requieren
verificación. Respeta las instrucciones de la tarea sobre si ejecutar comprobaciones.

# 📋 Prerrequisitos (Pre-flight checks)

Antes de escribir o ejecutar pruebas, verifica:

1. Lee las instrucciones del proyecto (`AGENTS.md`) y su mapa (`REPO-MAP.md`, si existe).
2. Localiza el comando de tests, el runner y la estructura de pruebas que ya usa el proyecto.
3. Comprueba si hay CI configurada y qué comprobaciones ejecuta.
4. Confirma si el entorno permite ejecutar las pruebas (servicios, credenciales, datos) o si
   hay que limitarse a un subconjunto.
5. No instales frameworks ni dependencias de test sin una necesidad concreta y autorización.

Salvo que el proyecto diga otra cosa, aplica
[`../../rules/code-conventions.md`](../../rules/code-conventions.md): identificadores y
nombres de tests en inglés.

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)

## Paso 1: Entender el comportamiento

- Lee las instrucciones del proyecto y comprueba sus convenciones, comandos y estructura
  de pruebas existentes.
- Identifica el resultado esperado desde la perspectiva de quien usa la función o de otro
  sistema que depende de ella.
- Para un error, busca una reproducción fiable y el resultado correcto esperado antes de
  escribir una prueba de regresión.
- Distingue requisitos explícitos, comportamiento actual y supuestos. Si falta una decisión
  que cambia significativamente el resultado, pregunta; si no, documenta el supuesto.

## Paso 2: Evaluar riesgo y alcance

Considera qué puede fallar y qué impacto tendría: entradas límite, errores, permisos,
persistencia, llamadas externas, concurrencia, compatibilidad o caminos de recuperación.
Prueba los riesgos pertinentes al cambio; no intentes cubrir casos hipotéticos sin relación
con él.

## Paso 3: Elegir el nivel de prueba

Usa el nivel más pequeño que dé confianza en el comportamiento y añade niveles superiores
cuando sea necesario validar límites reales entre componentes:

- **Unidad:** lógica aislada, transformaciones y decisiones locales.
- **Integración:** interacción entre componentes, almacenamiento, transporte o adaptadores.
- **Contrato:** compatibilidad de una interfaz con consumidores o proveedores.
- **Sistema o extremo a extremo:** un recorrido de usuario o sistema a través de varias
  partes reales.
- **Validación no basada en tests:** por ejemplo, validación de datos, reproducibilidad,
  compilación, comprobación estática o una inspección manual cuando el tipo de proyecto lo
  requiera.

No añadas capas redundantes solo para aumentar el número de pruebas. Si el proyecto usa
otros nombres o convenciones, sigue los suyos.

## Paso 4: Diseñar casos y datos

- Prioriza el camino esperado, los límites importantes y los errores recuperables.
- Mantén cada prueba centrada en un comportamiento observable y con un motivo claro.
- Usa datos pequeños, deterministas y representativos. Evita datos privados, credenciales,
  dependencias de la hora actual y aleatoriedad sin semilla controlada.
- Aísla servicios externos cuando una prueba de lógica no necesite verificarlos; usa los
  dobles o simuladores ya establecidos por el proyecto.
- Conserva al menos una comprobación de integración o contrato cuando el riesgo esté en la
  interacción real entre componentes. No sustituyas tanto que la prueba deje de comprobar
  esa interacción.
- Evita acoplar las pruebas a detalles internos que puedan cambiar sin alterar el
  comportamiento público.

## Paso 5: Implementar y ejecutar

- Amplía primero el conjunto de pruebas y utilidades existente; no introduzcas otro
  framework o dependencia sin una necesidad concreta.
- Escribe o actualiza las pruebas junto al cambio de comportamiento, siguiendo los nombres,
  estructura y formato del proyecto.
- Ejecuta primero las comprobaciones más acotadas relacionadas con el cambio. Después,
  amplía la ejecución según el riesgo, las reglas del proyecto y el flujo de trabajo
  aplicable.
- No ejecutes pruebas que requieran servicios reales, credenciales, datos costosos o efectos
  externos sin que la tarea y el entorno lo autoricen.
- Si una comprobación no puede ejecutarse, identifica el bloqueo concreto y no la presentes
  como superada.

## Paso 6: Diagnosticar fallos

- Lee el error y determina si es una regresión, un defecto de la prueba, una dependencia
  ambiental o una prueba inestable.
- Intenta reproducir el fallo de forma acotada antes de cambiar código o configuración.
- Corrige la causa, no solo la expectativa. No desactives, omitas ni debilites una prueba
  para ocultar un fallo sin justificarlo y explicarlo.
- Si el fallo es intermitente, identifica la fuente de no determinismo (orden, tiempo,
  concurrencia, aleatoriedad, red o estado compartido) y elimina esa dependencia cuando sea
  posible.

## Paso 7: Informar el resultado

Resume qué comportamientos se cubrieron, qué comprobaciones se ejecutaron y si pasaron.
Explica las áreas relevantes que quedaron sin verificar y el motivo. No confundas
"comando ejecutado" con "cobertura suficiente", ni afirmes haber ejecutado algo que no se
ejecutó.

# 💡 Ejemplos

## Cambio pequeño

Al corregir una función que normaliza una entrada, cubre un caso habitual, entradas vacías
o límite y el error previsto. Empieza por una prueba unitaria. Añade una comprobación de
nivel superior solo si el fallo pudo originarse en la interfaz con quien llama a la
función.

## Flujo con dependencias: recuperación en una RAG

Si se modifica cómo se recuperan fragmentos, valida el orden y la cantidad de resultados,
la consulta sin coincidencias y el error de recuperación que el sistema deba manejar.
Comprueba la lógica de ranking con datos controlados; prueba la integración con el
recuperador en el nivel que permita el proyecto. No llames a un modelo o servicio remoto
real para verificar lógica determinista, salvo que la propia integración externa sea el
objeto de la prueba y el entorno esté autorizado.

# 🛑 Reglas y Restricciones (Anti-patrones)

- No fijes un porcentaje global de cobertura ni persigas cobertura como sustituto de
  comprobar comportamientos importantes.
- No presupongas qué runner, lenguaje, gestor de paquetes o plataforma CI se utiliza.
- No cambies código de producción solo para facilitar una prueba sin evaluar antes si el
  diseño de producción necesita mejorar.
- No borres ni saltes pruebas existentes para conseguir una ejecución verde.
- No registres secretos ni datos personales en fixtures, salidas o logs.

