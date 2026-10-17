---
name: python-environments
description: Úsalo al iniciar o mantener proyectos Python, para gestionar entornos virtuales, dependencias y reproducibilidad de forma ordenada.
---

# 🎯 Propósito
Trabajar en proyectos Python con **entornos aislados** y dependencias declaradas, evitando el clásico
"en mi máquina funciona". Aplica a scripts, APIs, notebooks y proyectos de datos/IA.

# 🚦 Cuándo usarla (Triggers)
Activa esta skill siempre que:
- Inicies un proyecto Python nuevo.
- Instales o actualices dependencias.
- El usuario reporte errores de versiones o "no encuentra el módulo".

# 📋 Prerrequisitos (Pre-flight checks)
1. Comprueba la versión de Python objetivo (`python3 --version`).
2. Verifica si ya existe un entorno (`.venv/`) o un `requirements.txt`/`pyproject.toml`.

# 🛠️ Flujo de Trabajo (SOP)

## Paso 1: Crear entorno virtual aislado
- Usa SIEMPRE un entorno virtual; nunca instales en el Python del sistema.

```bash
python3 -m venv .venv
source .venv/bin/activate      # Linux / macOS
# .venv\Scripts\activate       # Windows
```

## Paso 2: Declarar dependencias
- Mantén las dependencias en `requirements.txt` (o `pyproject.toml`).
- **Pinea versiones** para reproducibilidad (`paquete==1.2.3`). Si el proyecto crece, separa
  `requirements.txt` (runtime) de `requirements-dev.txt` (desarrollo).

## Paso 3: Documentar el arranque
- Añade en el `README` (o un `Makefile`) los 3 pasos: crear entorno, instalar, ejecutar.

## Paso 4: Calidad (opcional, sin herramienta fija)
- Considera un linter/formateador. Opciones habituales: **ruff** (todo en uno), o
  **black** + **flake8**/**isort**. Elige uno y sé consistente en el proyecto.
- Considera pruebas con `pytest`.

## Paso 5: Validación
- Levanta el proyecto desde cero en un entorno limpio para verificar que las instrucciones funcionan.

# 🛑 Reglas y Restricciones (Anti-patrones)
- **NUNCA** commitees el entorno virtual (`.venv/`) → añádelo a `.gitignore`.
- **NUNCA** instales con `sudo pip`.
- **NUNCA** mezcles dependencias de desarrollo y de producción en un mismo archivo si el proyecto crece.
- **NUNCA** dejes `requirements.txt` sin versiones si el proyecto es crítico.
- **SIEMPRE** declara la versión de Python requerida.

# 💡 Ejemplos

```bash
# Entorno limpio y reproducible
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

```text
# .gitignore
.venv/
__pycache__/
*.pyc
```

```text
# requirements.txt
fastapi==0.115.0
uvicorn==0.32.0
```
