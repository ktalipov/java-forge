# Конвенция коммитов

Основа: [Conventional Commits](https://www.conventionalcommits.org/), адаптированные под обучение.
Формат проверяется хуком `.githooks/commit-msg` (включается через `./scripts/setup.sh`).

```
<type>(<scope>): <summary>

<body — необязательно>
```

## Типы

| Тип | Когда использовать | Пример |
|-----|--------------------|--------|
| `theory` | конспект, заметки, схемы | `theory(collections): add HashMap internals note` |
| `practice` | код упражнений и экспериментов | `practice(collections): implement SimpleHashMap with chaining` |
| `test` | только тесты | `test(collections): cover collisions and resize` |
| `project` | работа над мини-проектом | `project(hangman): add word list loading from file` |
| `fix` | исправление ошибки в своём коде или конспекте | `fix(core): correct off-by-one in palindrome check` |
| `refactor` | улучшение кода без смены поведения | `refactor(oop): extract Shape interface` |
| `review` | повторение, самопроверка, недельный обзор | `review(core): answer self-check questions` |
| `docs` | README, ROADMAP, PROGRESS | `docs: tick operators topic in PROGRESS` |
| `chore` | настройка, зависимости, скрипты | `chore: bump junit to 5.13.4` |
| `ci` | GitHub Actions | `ci: cache maven dependencies` |

## Scope

Имя модуля без номера: `core`, `oop`, `exceptions`, `generics`, `collections`, `streams`, `io`, `concurrency`, `jvm`, `testing`, `build`, `patterns`, `database`, `spring`, либо имя проекта (`hangman`). Для `docs`, `chore`, `ci` scope можно не указывать.

## Правила

1. Summary на английском, в повелительном наклонении: `add`, а не `added`.
2. До 72 символов, без точки в конце.
3. Один коммит = одна логическая вещь. Теорию и практику не смешиваем.
4. Каждый коммит собирается. Тесты не ломаем.
5. В теле объясняй **почему** и что оказалось неочевидным, а не пересказывай диф.
6. Черновые коммиты (`wip`) перед PR сворачиваем: `git commit --amend` или `git rebase -i`.

## Хорошо и плохо

| Плохо | Хорошо |
|-------|--------|
| `update` | `theory(oop): add notes on interfaces vs abstract classes` |
| `fixed stuff` | `fix(core): handle empty string in isPalindrome` |
| `Added HashMap, tests and notes, updated progress` | три коммита: `practice`, `test`, `docs` |
| `practice(core): Added overflow demo.` | `practice(core): add integer overflow demo` |

## Пример истории одной темы

```
theory(collections): add HashMap internals note
practice(collections): implement SimpleHashMap with chaining
test(collections): cover collisions and resize
refactor(collections): extract resize logic into helper
review(collections): answer self-check questions
docs: tick HashMap internals in PROGRESS
```

Читая такой лог, видно, как шло обучение.

## Как часто коммитить

Каждые 30–60 минут или при завершении логического куска. Минимум один осмысленный коммит в день: так получается стабильный ритм.
