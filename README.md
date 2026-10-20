# ☕ java-forge

![CI](https://github.com/<USERNAME>/java-forge/actions/workflows/ci.yml/badge.svg)

Дневник углублённого изучения Java: **конспекты своими словами + практический код с тестами + история коммитов как доказательство прогресса.**

Цель: пройти путь от прочного фундамента языка до Spring Boot и закрепить его 2–3 проектами.

---

## Как это работает

```mermaid
flowchart LR
    A[Issue: тема] --> B[Ветка topic/NN-slug]
    B --> C[theory: конспект]
    C --> D[practice: код]
    D --> E[test: JUnit]
    E --> F[review: самопроверка]
    F --> G[PR в main]
    G --> H[PROGRESS.md ✅]
```

Каждая тема проходит один и тот же цикл. Тема считается **закрытой**, только если выполнено всё:

| # | Критерий | Где виден |
|---|----------|-----------|
| 1 | Конспект написан своими словами по шаблону | `NN-module/notes/` |
| 2 | Есть практика: минимум 3 задачи | `NN-module/src/main/java` |
| 3 | Тесты зелёные (`mvn verify`) | `NN-module/src/test/java`, CI |
| 4 | Вопросы для самопроверки отвечены без подсказок | конец конспекта |
| 5 | Отметка в `docs/PROGRESS.md` | PR в `main` |

---

## Структура репозитория

```
java-forge/
├── README.md
├── pom.xml                  # родительский Maven-проект
├── .github/
│   ├── workflows/ci.yml     # сборка и тесты на каждый push/PR
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── ISSUE_TEMPLATE/topic.md
├── .githooks/commit-msg     # проверка формата коммитов
├── .gitmessage              # шаблон сообщения коммита
├── docs/
│   ├── ROADMAP.md           # что учим и в каком порядке
│   ├── WORKFLOW.md          # ветки, PR, теги, ритм недели
│   ├── COMMITS.md           # конвенция коммитов
│   ├── PROGRESS.md          # общий трекер
│   ├── templates/           # шаблоны конспекта и недельного обзора
│   └── reviews/             # недельные обзоры YYYY-Www.md
├── scripts/
│   ├── setup.sh             # включает хуки и шаблон коммита
│   ├── new-topic.sh         # создаёт конспект + заготовку кода и теста
│   ├── new-module.sh        # создаёт новый модуль
│   ├── new-project.sh       # создаёт мини-проект
│   └── new-review.sh        # создаёт недельный обзор
└── 01-core/                 # один модуль = одна большая тема
    ├── pom.xml
    ├── README.md            # чек-лист тем модуля
    ├── notes/               # теория (Markdown)
    └── src/
        ├── main/java/dev/journey/core/   # практика
        └── test/java/dev/journey/core/   # тесты
└── projects/                # мини-проекты, каждый = Maven-модуль
    ├── pom.xml              # сюда new-project.sh подключает проекты
    ├── README.md            # план проектов и как их вести
    └── hangman/             # пример: создаётся скриптом
        ├── README.md        # цель, требования, архитектура, как запустить
        └── src/             # код и тесты
```

Остальные модули (`02-oop`, `03-exceptions`, …) создаются командой `./scripts/new-module.sh` по мере прохождения. Полный список в [docs/ROADMAP.md](docs/ROADMAP.md).

Мини-проекты живут в `projects/` и создаются командой `./scripts/new-project.sh hangman "Console Hangman game"`. Подробнее в [projects/README.md](projects/README.md).

---

## Быстрый старт

Нужны JDK 21+ (рекомендуется 25 LTS), Maven 3.9+, Git.

```bash
git clone https://github.com/<USERNAME>/java-forge.git
cd java-forge
./scripts/setup.sh                  # хуки + шаблон коммита (один раз)
mvn verify                          # убедись, что всё собирается

# новая тема:
git checkout -b topic/01-operators
./scripts/new-topic.sh 01-core 02 "operators and control flow"
```

На Windows запускай скрипты из Git Bash или WSL.

---

## Документы

- [Roadmap](docs/ROADMAP.md): программа и источники
- [Проекты](projects/README.md): мини-проекты и как их вести
- [Workflow](docs/WORKFLOW.md): как работать каждый день и каждую неделю
- [Коммиты](docs/COMMITS.md): формат и примеры
- [Progress](docs/PROGRESS.md): трекер по модулям

## Правила

- Конспекты пишутся **своими словами**. Не копируй текст из книг и сайтов, только ссылки на источник.
- В `main` всегда рабочая сборка.
- Один коммит = одна логическая вещь.
- Не коммитим `target/`, IDE-файлы, секреты и большие бинарники.
