---
name: docker-and-compose
description: Úsalo al crear o revisar Dockerfiles y docker-compose, para lograr imágenes ligeras, seguras y reproducibles.
---

# 🎯 Propósito
Construir contenedores **seguros, pequeños y reproducibles**, y orquestar entornos de desarrollo
con Docker Compose. Aplica a cualquier stack (Node, Python, Go…).

# 🚦 Cuándo usarla (Triggers)
Activa esta skill siempre que:
- Crees o modifiques un `Dockerfile` o un `docker-compose.yml`.
- El usuario pida "dockerizar" una aplicación.
- Necesites un entorno de desarrollo reproducible con servicios (BD, caché…).

# 📋 Prerrequisitos (Pre-flight checks)
1. Comprueba si ya existe un `Dockerfile`/`compose` para no duplicar.
2. Verifica que existe un `.dockerignore` (si no, créalo).

# 🛠️ Flujo de Trabajo (SOP)

## Paso 1: Dockerfile multi-stage
- Separa la fase de **build** de la de **runtime**; copia solo lo necesario.
- Fija versiones concretas de imagen base (`node:22.11-alpine`, no `node:latest`).

## Paso 2: Seguridad
- Ejecuta como usuario **no-root** (`USER app`).
- No copies secretos al build; usa `--mount=type=secret` o variables en runtime.
- Prefiere imágenes mínimas (`alpine`, `distroless`).

## Paso 3: Capas y caché
- Copia primero los manifiestos de dependencias (`package.json`, `requirements.txt`) y luego el código, para aprovechar la caché de capas.

## Paso 4: Compose para desarrollo
- Define servicios con `healthcheck`, `depends_on` y variables desde `.env`.

## Paso 5: Validación
- Ejecuta `docker build` y verifica que el contenedor arranca y responde.

# 🛑 Reglas y Restricciones (Anti-patrones)
- **NUNCA** uses la etiqueta `latest` en producción.
- **NUNCA** ejecutes el proceso como `root`.
- **NUNCA** hardcodees secretos en el `Dockerfile` o `compose`.
- **NUNCA** uses `ADD` cuando `COPY` basta.
- **SIEMPRE** añade un `.dockerignore` (evita copiar `node_modules`, `.git`, `.env`).

# 💡 Ejemplos

**❌ MAL:**
```dockerfile
FROM node:latest
COPY . .
RUN npm install
CMD npm start
```

**✅ BIEN:**
```dockerfile
# ---- build ----
FROM node:22.11-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ---- runtime ----
FROM node:22.11-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
USER node
EXPOSE 3000
CMD ["node", "dist/main.js"]
```
