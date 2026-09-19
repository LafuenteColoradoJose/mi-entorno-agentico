# 🔄 Master Workflow: Software Development Life Cycle (SDLC)

Esta regla define el ciclo de vida OBLIGATORIO para la creación de cualquier componente, módulo, refactorización o proyecto. Actúa como el sistema nervioso central del agente.

## El Pipeline de Desarrollo Agéntico

El agente NUNCA debe saltar ciegamente a escribir código sin haber consolidado las fases previas. El proceso sigue este flujo estricto:

 DEFINE          PLAN           BUILD          VERIFY         REVIEW          SHIP
 ┌──────┐      ┌──────┐      ┌──────┐      ┌──────┐      ┌──────┐      ┌──────┐
 │ Idea │ ───▶ │ Spec │ ───▶ │ Code │ ───▶ │ Test │ ───▶ │  QA  │ ───▶ │  Go  │
 │Refine│      │  PRD │      │ Impl │      │Debug │      │ Gate │      │ Live │
 └──────┘      └──────┘      └──────┘      └──────┘      └──────┘      └──────┘
  /spec          /plan          /build        /test         /review       /ship

## Fases y Pseudo-Comandos (Triggers)

1. **`/spec` (Define - Idea Refine):** 
   - **Objetivo:** Aclarar requerimientos.
   - **Acción:** Entiende qué quiere el usuario. Hazle preguntas de diseño, alcance y casos límite. PROHIBIDO escribir código aquí.

2. **`/plan` (Plan - Spec/PRD & Breakdown):** 
   - **Objetivo:** Trazar el mapa.
   - **Acción:** Rompe la tarea en subtareas secuenciales. Propón la estructura de archivos y patrones de diseño. Espera aprobación.

3. **`/build` (Build - Code Impl & Inline Docs):** 
   - **Objetivo:** Ejecutar la construcción.
   - **Acción:** Escribe el código incrementalmente basado en el plan.
   - **✅ Definition of Done (DoD):** Todo el código generado DEBE incluir documentación inline obligatoria desde su creación (JSDoc, TSDoc, Compodoc, Docstrings, etc.). No se acepta código sin documentar.

4. **`/test` (Verify - Test/Debug & Coverage):** 
   - **Objetivo:** Demostrar que funciona de forma robusta.
   - **Acción:** Escribe o ejecuta pruebas unitarias y E2E.
   - **✅ Definition of Done (DoD):** La cobertura de tests unitarios DEBE superar el **80%**. Si la cobertura es menor, el agente debe generar los tests faltantes antes de dar la fase por superada.

5. **`/review` (Review - QA Gate):** 
   - **Objetivo:** Auditoría de calidad.
   - **Acción:** Auto-revisión implacable (Accesibilidad, rendimiento, deuda técnica). Pide feedback humano.

6. **`/ship` (Ship - Go Live & Documentation Update):** 
   - **Objetivo:** Cerrar el ciclo y mantener el conocimiento.
   - **Acción:** Prepara el commit (Conventional Commits).
   - **✅ Definition of Done (DoD):** REVISIÓN GLOBAL DE DOCUMENTACIÓN. El agente debe revisar y actualizar los manuales del proyecto (`README.md`, `manual_tecnico.md`, `manual_usuario.md`, CHANGELOG, etc.) integrando la nueva funcionalidad desarrollada.

## Restricción Crítica (Freno de mano)
Si el usuario te dice simplemente *"Crea un componente"*, asume que estás en `/spec` o `/plan`. No saltes a `/build` ni escribas código sin antes trazar el plan y esperar validación.
