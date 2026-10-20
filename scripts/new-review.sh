#!/usr/bin/env bash
# Создаёт недельный обзор docs/reviews/YYYY-Www.md из шаблона.
#
# Использование: ./scripts/new-review.sh
set -euo pipefail
shopt -u patsub_replacement 2>/dev/null || true

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

WEEK="$(date +%G-W%V)"
TO="$(date +%F)"
FROM="$(date -d '6 days ago' +%F 2>/dev/null || date -v-6d +%F)"

OUT="$ROOT/docs/reviews/$WEEK.md"
[ ! -e "$OUT" ] || { echo "Уже существует: $OUT"; exit 1; }

content="$(cat "$ROOT/docs/templates/weekly-review.md")"
content="${content//\{\{WEEK\}\}/$WEEK}"
content="${content//\{\{FROM\}\}/$FROM}"
content="${content//\{\{TO\}\}/$TO}"
printf '%s\n' "$content" > "$OUT"

echo "Создано: $OUT"
echo "Коммит: review: add weekly review $WEEK"
