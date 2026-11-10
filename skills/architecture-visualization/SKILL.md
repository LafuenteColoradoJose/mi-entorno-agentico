---
name: architecture-visualization
description: Analiza un sistema o repositorio y crea o actualiza diagramas profesionales e interactivos de arquitectura, componentes, dependencias y flujos; actívala para visualizar cómo funciona una aplicación, API, RAG o pipeline.
---

<!--
PARA QUÉ SIRVE
Esta skill guía a un agente para convertir una descripción o un repositorio en una
visualización arquitectónica clara, navegable y respaldada por evidencia. Está inspirada
en el enfoque de Archify (diagramas de arquitectura a partir del código), pero es genérica:
no depende de Archify, de un proveedor de IA, de un framework ni de un lenguaje concreto.

PUNTO DE PARTIDA PARA OTROS AGENTES
Puedes mejorar esta skill manteniendo su portabilidad y sus principios de evidencia,
accesibilidad y honestidad. Revisa especialmente el método de inspección del repositorio,
el formato visual disponible en el proyecto y las comprobaciones de calidad. No añadas
dependencias obligatorias ni afirmes relaciones que el código o el usuario no confirmen.
La plantilla complementaria está en ../../templates/ARCHITECTURE-DIAGRAM.template.html.
-->

# Visualización de arquitectura

## Propósito

Ayudar a entender, explicar y compartir la estructura o el comportamiento de un sistema
mediante diagramas útiles. El resultado debe responder a una pregunta concreta: por
ejemplo, qué componentes existen, cómo fluye una petición o qué sucede cuando falla una
dependencia.

La visualización es un artefacto de documentación. No modifica ni ejecuta el sistema
representado.

## Cuándo usarla

Actívala cuando el usuario pida:

- dibujar, mapear o explicar la arquitectura de un repositorio o aplicación;
- visualizar componentes, dependencias, secuencias, datos o flujos de control;
- crear un diagrama interactivo, una página explicativa o un mapa técnico;
- documentar un caso como una RAG, una API, un proceso de ingesta o un despliegue.

No la actives para cambios de código que no necesiten explicación visual.

## Principios

1. **Empieza por la pregunta.** Aclara el alcance a partir de la petición. Si ya es
   concreto, continúa sin pedir confirmación. Si es amplio, elige una vista inicial útil
   (normalmente el flujo principal) y explica el alcance elegido.
2. **Investiga antes de dibujar.** Si hay repositorio, consulta primero sus instrucciones,
   mapa (`REPO-MAP.md`, si existe) y documentación de entrada. Localiza después los puntos
   relevantes del código, configuración y pruebas. Lee solo lo necesario.
3. **Sigue la evidencia.** Traza el flujo desde sus puntos de entrada y confirma las
   relaciones en el código/configuración. No inventes servicios, protocolos, almacenes,
   llamadas, secuencias ni garantías.
4. **Separa certeza de inferencia.** Distingue lo confirmado por el repositorio, lo
   aportado por el usuario y lo inferido. Señala las inferencias y las incógnitas en el
   propio artefacto o en su resumen.
5. **Controla el alcance.** Muestra los componentes necesarios para responder la pregunta.
   Agrupa detalles secundarios y evita convertir el diagrama en un inventario de archivos.
6. **Diseña para lectura rápida.** Usa nombres concretos, jerarquía visual, etiquetas
   breves, dirección de flujo consistente, contraste suficiente y una leyenda solo cuando
   haga falta. Evita cruces y adornos que no comuniquen información.
7. **Hazlo accesible.** Incluye título y descripción, estructura semántica, foco visible,
   controles utilizables con teclado y texto además del color para transmitir estados.
8. **Mantén el resultado portable.** Prefiere los formatos y herramientas que ya tenga el
   proyecto. No añadas dependencias nuevas (incluida Archify) solo para producir el
   diagrama.

## Flujo de trabajo

### 1. Elegir la vista

Selecciona el tipo que mejor responda a la pregunta:

- **Contexto:** sistema y actores externos.
- **Componentes:** módulos y sus responsabilidades.
- **Flujo:** recorrido de datos o control, por ejemplo pregunta → recuperación → respuesta.
- **Secuencia:** interacciones ordenadas entre actores/servicios.
- **Despliegue:** unidades ejecutables, infraestructura y conexiones configuradas.

Para un repositorio grande, crea primero una vista de alto nivel. Añade vistas secundarias
solo si responden preguntas diferentes.

### 2. Reunir evidencia

- Identifica entradas (rutas HTTP, comandos, eventos, tareas o interfaz) y salidas.
- Sigue las llamadas o transformaciones relevantes hasta completar el flujo solicitado.
- Comprueba dependencias externas en configuración y documentación; diferéncialas de las
  que están implementadas realmente.
- Registra rutas de archivo y símbolos que respalden los nodos y las conexiones.
- Si falta evidencia, omite la conexión o márcala como desconocida/inferida; no la
  completes con convenciones típicas del framework.

En diagramas basados en código, ofrece referencias concretas. En HTML, enlaza desde cada
elemento a una ruta relativa y, cuando sea posible, a líneas o símbolos estables. Si el
enlace no será navegable desde el contexto del lector, muestra la ruta como texto.

### 3. Preparar el modelo

Antes de maquetar, define una lista compacta de:

- nodos: identificador, nombre visible, responsabilidad y evidencia;
- conexiones: origen, destino, dirección, etiqueta y evidencia;
- límites: qué queda dentro/fuera del sistema;
- estados o ramas relevantes, como error, reintento, caché o ausencia de resultados.

Usa la misma entidad con el mismo nombre en todas las vistas. No mezcles procesos de
tiempo de ejecución con pasos manuales o fases de despliegue sin distinguirlos.

### 4. Crear el artefacto

1. Si el proyecto ya usa Mermaid, PlantUML, C4 u otro formato, sigue su convención.
2. Si el usuario quiere un archivo visual autónomo, parte de
   [`../../templates/ARCHITECTURE-DIAGRAM.template.html`](../../templates/ARCHITECTURE-DIAGRAM.template.html).
   Sustituye todo el contenido de ejemplo por el modelo verificado y adapta el diagrama;
   no dejes nodos, rutas, etiquetas ni afirmaciones ficticias.
3. Si no hay formato existente y no se necesita interactividad, prefiere Mermaid o una
   representación de texto mantenible antes de introducir código de interfaz.
4. Guarda el artefacto en la ubicación indicada por el usuario o en la convención de
   documentación del proyecto. No sobrescribas diagramas existentes sin revisar su
   propósito y contenido.

El HTML de la plantilla usa HTML, CSS, SVG y JavaScript nativos, sin bibliotecas remotas.
Conserva esta propiedad si el usuario pide un archivo que funcione sin conexión.

### 5. Revisar y entregar

Comprueba que:

- cada nodo y arista responde al alcance elegido y tiene respaldo o está marcado como
  inferencia;
- la dirección y las etiquetas de las conexiones se entienden sin explicación oral;
- el diagrama sigue siendo legible en pantalla estrecha y con zoom;
- los controles interactivos funcionan con ratón y teclado y no esconden información
  esencial;
- título, resumen, leyenda, rutas y nombres no conservan texto de ejemplo;
- la documentación no revela secretos ni datos sensibles encontrados durante la lectura.

Si el entorno permite previsualizar el HTML o renderizar el formato, inspecciona el
resultado visual. Si no puedes hacerlo, indícalo con claridad; no afirmes haber verificado
el renderizado.

Entrega un resumen breve con el propósito del diagrama, su ubicación, el alcance y las
limitaciones o inferencias relevantes. No vuelques el archivo completo en la respuesta.

## Restricciones

- No presentes una arquitectura supuesta como si estuviera confirmada por el código.
- No llames "tiempo real", "seguro", "resiliente" o "escalable" a un sistema sin evidencia.
- No añadas credenciales, datos privados, valores de entorno ni contenido sensible al
  artefacto.
- No copies código, marca o recursos visuales de productos de terceros. La estructura y
  el estilo del diagrama deben ser originales o seguir la licencia del proyecto.
- No hagas cambios funcionales en la aplicación al crear documentación visual.

