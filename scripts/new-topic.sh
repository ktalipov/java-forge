#!/usr/bin/env bash
# Создаёт конспект и заготовку кода + теста для новой темы.
#
# Использование:
#   ./scripts/new-topic.sh <модуль> <номер темы> "<название на английском>"
# Пример:
#   ./scripts/new-topic.sh 01-core 02 "operators and control flow"
set -euo pipefail
shopt -u patsub_replacement 2>/dev/null || true

if [ $# -lt 3 ]; then
  echo "Использование: $0 <модуль> <NN> \"<название темы на английском>\""
  exit 1
fi

MODULE="$1"
NUM="$2"
shift 2
TITLE="$*"

if ! [[ "$NUM" =~ ^[0-9]{2}$ ]]; then
  echo "Номер темы должен быть двузначным: 01, 02, ... (получено: $NUM)"
  exit 1
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ -d "$ROOT/$MODULE" ] || { echo "Модуль $MODULE не найден"; exit 1; }

SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
[ -n "$SLUG" ] || { echo "Название должно содержать латинские буквы или цифры"; exit 1; }

CLASS="$(echo "$SLUG" | awk -F- '{for (i = 1; i <= NF; i++) printf "%s%s", toupper(substr($i, 1, 1)), substr($i, 2)}')Practice"
case "$CLASS" in [0-9]*) CLASS="T$CLASS" ;; esac

SCOPE="${MODULE#*-}"
PKG_DIR="dev/journey/$(echo "$SCOPE" | tr -d '-')"
PKG="${PKG_DIR//\//.}"
DATE="$(date +%F)"

NOTE="$ROOT/$MODULE/notes/$NUM-$SLUG.md"
MAIN="$ROOT/$MODULE/src/main/java/$PKG_DIR/$CLASS.java"
TEST="$ROOT/$MODULE/src/test/java/$PKG_DIR/${CLASS}Test.java"

for f in "$NOTE" "$MAIN" "$TEST"; do
  [ ! -e "$f" ] || { echo "Уже существует: $f"; exit 1; }
done
mkdir -p "$(dirname "$NOTE")" "$(dirname "$MAIN")" "$(dirname "$TEST")"

# конспект из шаблона
content="$(cat "$ROOT/docs/templates/theory-note.md")"
content="${content//\{\{TITLE\}\}/$TITLE}"
content="${content//\{\{MODULE\}\}/$MODULE}"
content="${content//\{\{DATE\}\}/$DATE}"
printf '%s\n' "$content" > "$NOTE"

cat > "$MAIN" <<EOF
package $PKG;

/**
 * Практика к теме "${TITLE}".
 * Конспект: ${MODULE}/notes/${NUM}-${SLUG}.md
 */
public final class $CLASS {

    private $CLASS() {
    }

    // TODO: задача 1
    // TODO: задача 2
    // TODO: задача 3
}
EOF

cat > "$TEST" <<EOF
package $PKG;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class ${CLASS}Test {

    @Test
    void placeholder() {
        // TODO: замени тестами на свои задачи
        assertThat(true).isTrue();
    }
}
EOF

echo "Создано:"
echo "  $NOTE"
echo "  $MAIN"
echo "  $TEST"
echo
echo "Дальше:"
echo "  git checkout -b topic/$NUM-$SLUG   # если ещё не создал ветку"
echo "  git add $MODULE/notes && git commit   # theory($SCOPE): add $SLUG note"
