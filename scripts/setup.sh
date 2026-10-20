#!/usr/bin/env bash
# Одноразовая настройка: хук проверки коммитов + шаблон сообщения.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [ ! -d .git ]; then
  echo "Это не git-репозиторий. Сначала выполни: git init"
  exit 1
fi

git config core.hooksPath .githooks
git config commit.template .gitmessage
chmod +x .githooks/* scripts/*.sh

echo "Готово:"
echo "  - хук commit-msg включён (формат коммитов проверяется)"
echo "  - шаблон .gitmessage подключён (откроется при git commit без -m)"
