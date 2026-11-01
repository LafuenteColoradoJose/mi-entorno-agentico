# 🪙 Economía de Contexto

> **Ámbito:** obligatoria en todos los proyectos. Es **stack-agnóstica**: aplica a cualquier
> lenguaje, framework, herramienta o agente.

## Principio

> **Lee lo justo para acertar, no más.**

Ahorrar contexto **no puede** comprometer la corrección. Si lees de menos y te equivocas,
el re-trabajo (y la re-lectura) cuesta más que lo ahorrado.

## Los 3 grifos del gasto

| Grifo | Qué lo abre | Cómo cerrarlo |
|---|---|---|
| **Leer de más** | Explorar el repo entero "por si acaso" | Mapa + lecturas dirigidas |
| **Repetir** | Volver a descubrir lo mismo cada sesión | Apuntar lo aprendido |
| **Escribir de más** | Volcar archivos completos | Responder con el cambio (diff) |

## Reglas

1. **Pregunta antes de leer.** Primero *"¿dónde está X?"* (búsqueda), y después lee **solo
   esa parte**. Nunca abras un archivo entero para usar 10 líneas.
2. **Lecturas dirigidas.** Lee por rangos de líneas o por símbolo. Si el archivo es grande,
   localiza la función y lee su bloque.
3. **No repitas.** Lo que ya descubriste se queda escrito (notas de sesión o el
   [`REPO-MAP.md`](../templates/REPO-MAP.template.md)). No lo vuelvas a buscar.
4. **Progressive disclosure.** Lee primero índices, READMEs y resúmenes; el detalle solo
   cuando haga falta.
5. **Salida en diffs.** Muestra únicamente lo que cambia. No reescribas archivos completos
   en la respuesta.
6. **Presupuesto por tarea.** Antes de explorar, estima el tamaño: una tarea pequeña no
   justifica recorrer medio repositorio.
7. **Verificación mínima suficiente.** Ejecuta el test/módulo afectado antes que la suite
   completa, salvo que el cambio sea transversal.
8. **Estructura vs. texto.** Para *dónde está / quién llama / qué impacto tiene*, usa
   herramientas estructurales si existen (grafo de código, LSP). Para cadenas, comentarios o
   configuración, usa búsqueda de texto (`grep`).

## Presupuesto orientativo

| Tamaño de la tarea | Exploración razonable | Entrega |
|---|---|---|
| **Pequeña** (1 archivo) | Mapa (si existe) + 1-3 archivos | Diff puntual |
| **Media** (varios módulos) | Mapa + módulos afectados | Diff + resumen |
| **Grande** (transversal) | Plan escrito primero, luego por partes | Plan + diffs por fase |

> Son orientaciones, no cuotas rígidas. La meta es **evitar la exploración ciega**, no
> racionar líneas.

## Señales de derroche

- Abrir archivos "por si acaso".
- Releer el mismo archivo en la misma sesión.
- Pegar archivos enteros en la respuesta.
- Buscar sin filtros y leer todas las coincidencias.
- Repetir la exploración en cada sesión.
- Comprimir o resumir información **crítica** y perder precisión.

## Cuándo NO escatimar

| Situación | Por qué |
|---|---|
| Debugging de un fallo raro | A veces hay que leer más contexto |
| Código que vas a reescribir | Necesitas entenderlo entero |
| Seguridad o migración crítica | La precisión manda sobre el ahorro |
| Primera vez en un repo | Invierte en generar el [`REPO-MAP.md`](../templates/REPO-MAP.template.md) |

## Relación con otras reglas

- [`master-workflow.md`](./master-workflow.md): fases y *Definition of Done*.
- [`code-conventions.md`](./code-conventions.md): archivos pequeños y enfocados abaratan las lecturas.
- [`multi-agent.md`](./multi-agent.md): el aislamiento de contexto es la versión multiagente de esta regla.
- Skill operativa: [`skills/context-economy/SKILL.md`](../skills/context-economy/SKILL.md).
