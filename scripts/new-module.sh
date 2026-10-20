#!/usr/bin/env bash
# Создаёт новый Maven-модуль со структурой notes/ + src/.
#
# Использование:
#   ./scripts/new-module.sh <NN-slug>
# Пример:
#   ./scripts/new-module.sh 02-oop
set -euo pipefail

if [ $# -ne 1 ] || ! [[ "$1" =~ ^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Использование: $0 <NN-slug>   например: $0 02-oop"
  exit 1
fi

MODULE="$1"
SLUG="${MODULE#*-}"
PKG_DIR="dev/journey/$(echo "$SLUG" | tr -d '-')"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ ! -e "$ROOT/$MODULE" ] || { echo "Модуль $MODULE уже существует"; exit 1; }

mkdir -p "$ROOT/$MODULE/notes" \
         "$ROOT/$MODULE/src/main/java/$PKG_DIR" \
         "$ROOT/$MODULE/src/test/java/$PKG_DIR"
touch "$ROOT/$MODULE/src/main/java/$PKG_DIR/.gitkeep" \
      "$ROOT/$MODULE/src/test/java/$PKG_DIR/.gitkeep"

cat > "$ROOT/$MODULE/pom.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <parent>
    <groupId>dev.journey</groupId>
    <artifactId>java-forge</artifactId>
    <version>1.0-SNAPSHOT</version>
  </parent>

  <artifactId>$SLUG</artifactId>
  <name>$MODULE</name>
</project>
EOF

cat > "$ROOT/$MODULE/README.md" <<EOF
# $MODULE

Статус: ⬜ не начат

## Темы

| # | Тема | Конспект | Практика | Тесты | Самопроверка |
|---|------|----------|----------|-------|--------------|
| 01 | | ⬜ | ⬜ | ⬜ | ⬜ |

Новая тема: \`./scripts/new-topic.sh $MODULE 01 "topic title"\`

## Итоговый конспект модуля

<!-- Что я понял за модуль (1 страница). Пишется в конце. -->
EOF

echo "Модуль $MODULE создан."
echo
echo "Добавь в корневой pom.xml, в блок <modules>:"
echo "    <module>$MODULE</module>"
echo
echo "Затем: git add . && git commit   # chore: add $MODULE module"
