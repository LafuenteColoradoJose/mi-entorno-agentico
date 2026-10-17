#!/usr/bin/env bash
# Valida la integridad del kit: frontmatter de skills y enlaces internos de Markdown.
# Uso: ./scripts/validate.sh   (desde cualquier punto de la raíz del repo)
set -euo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)"

fail=0

echo "→ Validando frontmatter de skills..."
if ! python3 - <<'PY'
import glob, sys, yaml
ok = True
files = sorted(glob.glob('skills/*/SKILL.md'))
if not files:
    print('  ✗ No se encontró ninguna skill en skills/*/SKILL.md'); ok = False
for f in files:
    txt = open(f, encoding='utf-8').read()
    if not txt.startswith('---'):
        print(f"  ✗ {f}: sin frontmatter"); ok = False; continue
    try:
        data = yaml.safe_load(txt.split('---', 2)[1])
    except Exception as e:
        print(f"  ✗ {f}: YAML inválido -> {e}"); ok = False; continue
    name, desc = data.get('name'), data.get('description')
    if not name or not desc:
        print(f"  ✗ {f}: faltan 'name' o 'description'"); ok = False; continue
    if '\n' in str(desc):
        print(f"  ✗ {f}: la description debe ser de UNA sola línea"); ok = False; continue
    print(f"  ✓ {f}")
sys.exit(0 if ok else 1)
PY
then fail=1; fi

echo "→ Validando enlaces internos de Markdown..."
if ! python3 - <<'PY'
import glob, os, re, sys
bad = []
for f in glob.glob('**/*.md', recursive=True):
    if '.git/' in f:
        continue
    base = os.path.dirname(f)
    for m in re.finditer(r'\]\((\.[^)\s#]+)?(#[^)\s]+)?\)', open(f, encoding='utf-8').read()):
        path, frag = m.group(1), m.group(2)
        target = f if not path else os.path.normpath(os.path.join(base, path))
        if path and not os.path.exists(target):
            bad.append(f"{f}: enlace roto {m.group(0)}"); continue
        if frag:
            ids = re.findall(r'<a id="([^"]+)"', open(target, encoding='utf-8').read())
            if frag[1:] not in ids:
                bad.append(f"{f}: ancla inexistente {m.group(0)}")
print('\n'.join('  ✗ ' + b for b in bad) if bad else '  ✓ enlaces OK')
sys.exit(1 if bad else 0)
PY
then fail=1; fi

if command -v gitleaks >/dev/null 2>&1; then
  echo "→ Escaneando secretos con gitleaks..."
  gitleaks detect --no-banner || fail=1
else
  echo "→ gitleaks no instalado: se omite el escaneo de secretos."
fi

if [ "$fail" -ne 0 ]; then
  echo "❌ Validación FALLIDA"
  exit 1
fi
echo "✅ Validación correcta"
