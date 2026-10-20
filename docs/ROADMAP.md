# Roadmap

Порядок модулей выстроен так, чтобы каждый следующий опирался на предыдущие. Сроки ориентировочные: ставь свой темп, но не перескакивай модули.

| # | Модуль | Ключевые темы | Ориентир |
|---|--------|---------------|----------|
| 01 | `core` | типы и переменные, операторы, управление потоком, массивы, `String`/`StringBuilder`, методы, varargs, передача по значению, `var`, text blocks, switch-выражения | 2–3 нед. |
| 02 | `oop` | классы, конструкторы, инкапсуляция, наследование, полиморфизм, абстрактные классы vs интерфейсы, `equals`/`hashCode`/`toString`, enum, record, sealed, вложенные классы, pattern matching, SOLID | 3–4 нед. |
| 03 | `exceptions` | иерархия исключений, checked vs unchecked, try-with-resources, собственные исключения, стратегии обработки | 1 нед. |
| 04 | `generics` | дженерики, ограничения типов, wildcards, PECS, стирание типов | 1–2 нед. |
| 05 | `collections` | `List`/`Set`/`Map`/`Queue`/`Deque`, внутреннее устройство `ArrayList` и `HashMap`, `TreeMap`, `Comparable`/`Comparator`, fail-fast итераторы, неизменяемые коллекции, сложность операций | 3 нед. |
| 06 | `streams` | функциональные интерфейсы, лямбды, ссылки на методы, Stream API, коллекторы, `Optional`, подводные камни parallel | 2 нед. |
| 07 | `io` | `Path`/`Files`, потоки, кодировки, сериализация, `java.time`, regex | 2 нед. |
| 08 | `concurrency` | `Thread`, `synchronized`, `volatile`, Java Memory Model (happens-before), `Lock`, atomics, `ExecutorService`, `CompletableFuture`, concurrent-коллекции, virtual threads | 4 нед. |
| 09 | `jvm` | загрузка классов, байткод (`javap`), области памяти, сборщики мусора, JIT, профилирование (JFR), reflection, аннотации | 3 нед. |
| 10 | `testing` | JUnit 5, AssertJ, Mockito, параметризованные тесты, TDD | 2 нед. |
| 11 | `build` | жизненный цикл Maven, зависимости, упаковка JAR, основы Gradle, логирование (SLF4J + Logback) | 1 нед. |
| 12 | `patterns` | ключевые паттерны GoF, чистый код, рефакторинг | 2 нед. |
| 13 | `database` | SQL, JDBC, транзакции и уровни изоляции, пул соединений, JPA/Hibernate (N+1, lazy), Flyway | 3–4 нед. |
| 14 | `spring` | IoC/DI, жизненный цикл бинов, REST, валидация, Spring Data JPA, Security, конфигурация, тесты Spring | 4–6 нед. |
| 15 | `projects` | итоговые проекты (см. ниже) | параллельно |

### Параллельный трек: алгоритмы

1–2 задачи в день. Папка `algo/` создаётся через `./scripts/new-module.sh 99-algo`, файлы по теме: `algo/.../TwoSum.java` с тестом. Коммит: `practice(algo): solve two-sum with hash map`.

### Итоговые проекты

Создаются командой `./scripts/new-project.sh <имя> "<описание>"`, подробности в [projects/README.md](../projects/README.md).

1. **CLI-менеджер задач** (после модуля 06): коллекции, streams, файлы, тесты.
2. **REST API с БД** (после модуля 14): Spring Boot, PostgreSQL, миграции, интеграционные тесты.
3. **Свободный проект** на выбор: то, что хочется довести до релиза.

## Критерий готовности модуля

- Все темы модуля отмечены в `README.md` модуля
- Тесты зелёные, CI проходит
- Написан итоговый конспект «Что я понял за модуль» (1 страница)
- Поставлен тег `m<NN>-done`, обновлён [PROGRESS.md](PROGRESS.md)

## Источники

- Herbert Schildt, *Java: The Complete Reference*
- [dev.java](https://dev.java): официальное обучение от Oracle
- Спецификации: [JLS](https://docs.oracle.com/javase/specs/) и JVMS
- Joshua Bloch, *Effective Java*
- Brian Goetz, *Java Concurrency in Practice*
- Baeldung: для точечных вопросов (источники всегда сверяй с документацией)

В конспекте для каждой темы указывай, откуда читал: раздел «Источники».
