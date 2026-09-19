---
name: html-semantics-and-a11y
description: Úsalo cuando crees, modifiques o refactorices código HTML, plantillas web o componentes UI para garantizar semántica HTML5, accesibilidad (a11y) y buenas prácticas de rendimiento.
---

# 🎯 Propósito
Garantizar que todo el código HTML generado sea digno de un desarrollador web Senior. El código debe ser 100% semántico, amigable para motores de búsqueda (SEO), accesible para lectores de pantalla (WAI-ARIA) y evitar la conocida "sopa de divs" (div soup).

# 🚦 Cuándo usarla (Triggers)
Activa esta skill siempre que:
- El usuario pida maquetar una página web, un layout o un componente visual.
- El usuario pida refactorizar, auditar o limpiar código HTML existente.
- Estés escribiendo plantillas para frameworks (Angular, Vue, Svelte) o JSX/TSX (React).

# 📋 Prerrequisitos (Pre-flight checks)
Antes de generar el código, verifica lo siguiente:
1. Identifica en qué framework o contexto estás trabajando (HTML puro, Angular, React, etc.) para adaptar la sintaxis (ej. `class` vs `className`).
2. Verifica si el usuario ha especificado alguna metodología CSS (como BEM o Tailwind) para integrarla correctamente en las clases.

# 🛠️ Flujo de Trabajo (Standard Operating Procedure)

## Paso 1: Planificación Semántica (Estructura)
- En lugar de usar `<div>`, busca primero la etiqueta HTML5 adecuada: `<main>`, `<article>`, `<section>`, `<nav>`, `<aside>`, `<header>`, `<footer>`.
- Usa `<form>`, `<fieldset>` y `<legend>` para agrupaciones de datos de entrada.

## Paso 2: Jerarquía de Encabezados (SEO y Lecturabilidad)
- Asegúrate de que haya un único `<h1>` por página (o por vista principal).
- La estructura de encabezados debe ser secuencial. Nunca te saltes un nivel (ej. pasar de `<h2>` a `<h4>` es un error).

## Paso 3: Accesibilidad (a11y)
- Las imágenes DEBEN llevar el atributo `alt`. Si son puramente decorativas, usa `alt=""` explícitamente.
- Todos los elementos interactivos deben ser accesibles por teclado (`tabindex="0"` solo si no es un botón o enlace nativo).
- Si un botón solo tiene un icono, DEBE incluir un `aria-label` descriptivo.

## Paso 4: Optimización de Rendimiento
- Añade el atributo `loading="lazy"` a las etiquetas `<img>` o `<iframe>` que no estén en el primer viewport (below the fold).

# 🛑 Reglas y Restricciones (Anti-patrones)
- **NUNCA** uses un `<div>` o `<span>` con un evento `onClick` simulando un botón. Usa SIEMPRE `<button type="button">`.
- **NUNCA** pongas atributos de estilo en línea (ej. `style="color: red;"`).
- **NUNCA** uses etiquetas de formato obsoletas como `<b>`, `<i>`, `<center>` o `<font>`. Usa `<strong>`, `<em>` o CSS.

# 💡 Ejemplos de Salida Esperada

**❌ MAL (Sopa de Divs y Cero Accesibilidad):**
```html
<div class="card">
  <div class="title">Mi Artículo</div>
  <img src="foto.jpg">
  <div class="btn" onclick="guardar()">Guardar</div>
</div>
```

**✅ BIEN (Semántico y Accesible):**
```html
<article class="card">
  <h2 class="card__title">Mi Artículo</h2>
  <img src="foto.jpg" alt="Persona usando el producto en la oficina" loading="lazy">
  <button type="button" class="btn btn--primary" aria-label="Guardar el artículo">
    Guardar
  </button>
</article>
```
