---
name: ux-ui-design-principles
description: Úsalo para tomar decisiones de diseño visual, jerarquía, espaciado, diseño responsivo (Mobile-First), dashboards, y experiencia de usuario (UX).
---

# 🎯 Propósito
Instruir al agente para que piense y actúe como un Diseñador UX/UI Senior. El objetivo es crear interfaces intuitivas, responsivas, con baja carga cognitiva y dashboards que faciliten la toma de decisiones en cualquier dispositivo (desde móviles hasta monitores ultrawide).

# 🚦 Cuándo usarla (Triggers)
Activa esta skill siempre que:
- Se te pida idear, bosquejar o diseñar la interfaz visual de una aplicación.
- El usuario pida adaptar la pantalla a dispositivos móviles o hacerla "Responsive".
- Estés construyendo **Dashboards, gráficos o paneles de control**.
- El usuario pregunte "¿Cómo podríamos mejorar esta pantalla?".

# 📋 Prerrequisitos (Pre-flight checks)
Antes de proponer o escribir estilos, verifica si el proyecto ya usa un sistema de diseño o framework CSS (como Tailwind, Material, Bootstrap) para reutilizar sus tokens y su sistema de breakpoints nativo.

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)

## Paso 1: Previsión de Estados (State Management)
Debes prever cómo se verá la interfaz en los 4 estados básicos:
1. **Ideal State:** Datos cargados correctamente.
2. **Empty State:** No hay datos aún.
3. **Error State:** Falló la carga.
4. **Loading State:** Transición visual mientras se obtienen datos.

## Paso 2: Jerarquía Visual y Foco
- Define cuál es la única acción principal de la pantalla y destácala.
- **Regla de Oro de la Atención:** *"Si todo llama la atención, nada llama la atención."* Cada elemento debe tener un propósito claro.

## Paso 3: Sistema de Espaciado (Grid de 8px)
- Todos los márgenes y paddings deben ser múltiplos de 8 (8, 16, 24, 32, 40, 48px).

## Paso 4: Diseño Responsivo (Mobile-First)
- **Mobile-First Nativo:** Todo el CSS base debe estar pensado para 1 sola columna (móvil). Usa SIEMPRE media queries con `min-width` para adaptar el layout a pantallas más grandes progresivamente.
- **Layouts Fluidos:** Utiliza unidades relativas (`%`, `rem`, `vw`, `vh`) y apóyate en CSS Flexbox o Grid en lugar de flotados o posiciones absolutas.
- **Accesibilidad Táctil (Touch Targets):** Cualquier botón o área interactiva debe medir como mínimo **48x48 píxeles** para evitar errores táctiles en móviles.

# 🛑 Reglas y Restricciones (Anti-patrones Generales)
- **NUNCA** uses anchos fijos en píxeles (ej. `width: 800px`) en contenedores principales de layout.
- **NUNCA** pongas dos botones primarios idénticos juntos.
- **NUNCA** confíes únicamente en el color para comunicar un error o éxito.
- **NUNCA** justifiques textos largos en la web.

# 📊 Reglas Específicas para Dashboards y Visualización de Datos
Al crear o auditar paneles de datos, EVITA estos errores capitales:
1. **Elegir el gráfico incorrecto:** No uses gráficos de pastel para más de 3-4 categorías. Usa barras.
2. **Mostrar demasiada información:** Menos esfuerzo cognitivo es mejor.
3. **Manipular ejes:** Los ejes Y de gráficos de barras SIEMPRE empiezan en 0.
4. **Mostrar KPIs sin contexto:** Compara con un periodo anterior o un objetivo (ej. "Ventas: 500 (↑ 5%)").
5. **Dashboards en Móvil (Responsive DataViz):**
   - Las gráficas (Echarts, Chart.js, etc.) DEBEN estar en contenedores fluidos (`width: 100%`).
   - Las tablas de datos complejas deben ir envueltas obligatoriamente en un contenedor con `overflow-x: auto` o transformarse en vista de tarjetas (cards) en resoluciones pequeñas para NO romper la pantalla.
