# Проекты

Проекты трека **Java Core**. Каждый закрепляет несколько модулей: в нём видно, умеешь ли ты собрать из знаний рабочую программу.

Каждый проект это отдельный Maven-модуль в `projects/<имя>/` со своим README, кодом и тестами.

Большие и долгоживущие проекты (диплом, рабочие сайты, всё не на Java) сюда не кладём: они живут в отдельных репозиториях.

## План проектов

| # | Проект | Начинать после | Что закрепляет | Статус |
|---|--------|----------------|----------------|--------|
| 1 | **Hangman** (виселица) | `01 core` | строки, массивы, циклы, методы, ввод с консоли | ⬜ |
| 2 | **Bank system** (банковская система) | `02 oop` | классы, наследование, интерфейсы, `equals`/`hashCode`, исключения | ⬜ |
| 3 | **Log analyzer** (анализатор логов) | `06 streams` и `07 io` | файлы, Stream API, коллекции, regex, `java.time` | ⬜ |
| 4 | **File indexer** (параллельный индексатор файлов) | `08 concurrency` | потоки, `ExecutorService`, `ConcurrentHashMap`, гонки данных | ⬜ |
| 5 | **StockPilot**: Inventory & Stock Management System | JDBC и Swing | Swing, JDBC, слои приложения, всё пройденное | ⬜ |
| 6 | **StockPilot API** (тот же склад как REST-сервис) | `14 spring` | Spring Boot, REST, JPA, тесты | ⬜ |

### Создание проектов

```bash
./scripts/new-project.sh hangman "Console Hangman game"
./scripts/new-project.sh bank-system "Bank system built with OOP"
./scripts/new-project.sh log-analyzer "Log file analyzer (streams, io)"
./scripts/new-project.sh file-indexer "Parallel file indexer (concurrency)"
./scripts/new-project.sh stockpilot "StockPilot: inventory and stock management (Swing, JDBC)"
./scripts/new-project.sh stockpilot-api "StockPilot as a Spring Boot REST service"
```

Создавай проект, когда дошёл до нужного модуля, а не заранее.

### Заметки по каждому

**Hangman.** Достаточно модуля `core`. Раздели логику игры (класс, который хранит слово и угаданные буквы) и ввод-вывод в консоль: логику можно тестировать, консоль нет.

**Bank system.** Начинай после `02 oop`. Исключения (`InsufficientFundsException` и т.п.) естественно просятся в проект, а они в модуле `03 exceptions`. Изучи его до того, как закончишь проект, либо сначала сделай без них и добавь потом отдельным PR.

**Log analyzer.** Нужны `streams` и `io`. Придумай формат лога заранее и положи пример в `src/test/resources`, чтобы тесты читали настоящий файл.

**File indexer.** Консольная программа: несколько потоков обходят папку и строят индекс «слово → файлы, где оно встречается». Сначала напиши однопоточную версию и тесты, потом распараллель и сравни время. Смысл проекта в том, чтобы самому встретить гонку данных и починить её (`ConcurrentHashMap`, `merge`), а не читать о ней.

**StockPilot.** Самый большой, поэтому у него три особенности:

- **В roadmap нет Swing.** JDBC есть в модуле `13 database`, а отдельной темы про Swing нет. Перед проектом нужен короткий блок про оба.
- **Архитектура слоями:** `ui` (Swing), `service` (логика), `dao` (JDBC). Тогда логику и доступ к данным можно тестировать без окон.
- **GUI не запускается в CI** (там нет экрана), поэтому тесты пишутся только на `service` и `dao`. Для `dao` в тестах удобна встроенная база H2 в памяти.

Ограничение шаблона: `new-project.sh` собирает обычный jar без зависимостей, поэтому `java -jar` не увидит драйвер JDBC. Для StockPilot понадобится добавить сборку «толстого» jar (maven-shade-plugin) или запускать из IDE. Решим, когда дойдёшь до проекта.

**StockPilot API.** Тот же домен (товары, остатки, движения), но сервис на Spring Boot и PostgreSQL, без Swing. Слои `service` и `dao` из StockPilot переедут почти без изменений, поэтому всё внимание уходит на Spring. Шаблон `new-project.sh` даёт только каркас: Spring Boot (BOM `spring-boot-dependencies` и `spring-boot-maven-plugin`) добавляется в `pom.xml` проекта уже на этом этапе.

## Как вести проект

1. Создай модуль скриптом и заполни в его README цель и требования.
2. Заведи в GitHub Milestone `project: <имя>`, а каждую фичу оформи как issue.
3. Одна фича = ветка `project/<имя>-<фича>` = один PR. Коммиты: `project(<имя>): <что сделано>`.
4. Код без тестов в `main` не попадает (для Swing: логика без тестов не попадает).
5. Закончил: заполни «Что я узнал» в README, поставь тег `<имя>-v1.0.0` и создай GitHub Release.

Подробности в [docs/WORKFLOW.md](../docs/WORKFLOW.md#проекты).
