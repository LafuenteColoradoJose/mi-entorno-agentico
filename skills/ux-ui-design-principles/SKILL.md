---
name: ux-ui-design-principles
description: Úsalo para tomar decisiones de diseño visual, jerarquía, espaciado, diseño de dashboards, estados de la interfaz (loading/error) y experiencia de usuario (UX).
---

# 🎯 Propósito
Instruir al agente para que piense y actúe como un Diseñador UX/UI Senior y Experto en Visualización de Datos. El objetivo es crear interfaces intuitivas, con baja carga cognitiva y dashboards que faciliten la toma de decisiones.

# 🚦 Cuándo usarla (Triggers)
Activa esta skill siempre que:
- Se te pida idear, bosquejar o diseñar la interfaz visual de una aplicación.
- Estés construyendo **Dashboards, gráficos o paneles de control**.
- Tengas que proponer paletas de color, tipografías o flujos de usuario.
- El usuario pregunte "¿Cómo podríamos mejorar esta pantalla?".

# 📋 Prerrequisitos (Pre-flight checks)
Antes de proponer o escribir estilos, verifica si el proyecto ya usa un sistema de diseño o framework CSS (como Tailwind, Material, Bootstrap) para reutilizar sus tokens.

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)

## Paso 1: Previsión de Estados (State Management)
Debes prever cómo se verá la interfaz en los 4 estados básicos:
1. **Ideal State:** Datos cargados correctamente.
2. **Empty State:** No hay datos aún.
3. **Error State:** Falló la carga.
4. **Loading State:** Transición visual mientras se obtienen datos.

## Paso 2: Jerarquía Visual y Foco
- Define cuál es la única acción principal de la pantalla y destácala.
- **Regla de Oro de la Atención:** *"Si todo llama la atención, nada llama la atención."* Cada elemento, color o KPI que agregues debe tener un propósito claro y ayudar a responder una pregunta.

## Paso 3: Sistema de Espaciado (Grid de 8px)
- Todos los márgenes y paddings deben ser múltiplos de 8 (8, 16, 24, 32, 40, 48px). 

# 🛑 Reglas y Restricciones (Anti-patrones Generales)
- **NUNCA** pongas dos botones primarios idénticos juntos.
- **NUNCA** confíes únicamente en el color para comunicar un error o éxito (por accesibilidad).
- **NUNCA** justifiques textos largos en la web.

# 📊 Reglas Específicas para Dashboards y Visualización de Datos
Al crear o auditar paneles de datos, **EVITA** estos 7 errores capitales:
1. **Elegir el gráfico incorrecto:** No uses gráficos de pastel (pie charts) para más de 3-4 categorías. Usa gráficos de barras para comparaciones.
2. **Mostrar demasiada información:** Un buen dashboard no es el que muestra más datos, sino el que requiere menos esfuerzo para entenderlos.
3. **Utilizar colores sin una lógica clara:** No uses colores aleatorios. Usa colores semánticos (rojo=mal, verde=bien) o variaciones de un mismo tono para el mismo tipo de dato.
4. **Manipular la percepción con los ejes:** Los ejes Y de los gráficos de barras deben empezar SIEMPRE en 0.
5. **Usar visualizaciones que dificultan las comparaciones:** (ej. gráficos 3D que distorsionan el volumen).
6. **Mostrar KPIs sin contexto:** Un número suelto (ej. "Ventas: 500") no sirve. Añade contexto (ej. "Ventas: 500 (↑ 5% vs mes anterior)").
7. **No crear una jerarquía visual:** Pon los KPIs clave arriba, tendencias en el medio, y tablas detalladas abajo.

# 💡 Ejemplos de Salida Esperada

**❌ MAL (Dashboard confuso):**
```html
<div>
  <h2>Ventas: 500</h2> <!-- Falta contexto -->
  <!-- Gráfico de pastel con 20 colores aleatorios -->
</div>
```

**✅ BIEN (Dashboard profesional):**
```html
<section>
  <h2 class="kpi-primary">Ventas: 500 <span class="trend up">↑ 5% vs mes pasado</span></h2>
  <!-- Gráfico de barras ordenado de mayor a menor con un solo color corporativo -->
</section>
```
