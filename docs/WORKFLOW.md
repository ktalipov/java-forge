# Workflow

## Ветки

| Ветка | Назначение | Пример |
|-------|-----------|--------|
| `main` | всегда рабочая сборка, законченные темы | |
| `topic/<NN>-<slug>` | одна тема, живёт 1–5 дней | `topic/05-hashmap-internals` |
| `project/<name>-<feature>` | одна фича мини-проекта, живёт 1–3 дня | `project/hangman-word-list` |
| `fix/<slug>` | исправления | `fix/readme-typo` |

Прямые коммиты в `main` допустимы только для мелких `docs`/`chore`.

## Цикл одной темы

```bash
git checkout main && git pull
git checkout -b topic/05-hashmap-internals
./scripts/new-topic.sh 05-collections 03 "hashmap internals"

# 1. читаешь источник, пишешь конспект
git add 05-collections/notes && git commit      # theory(collections): ...

# 2. пишешь код
git add 05-collections/src/main && git commit   # practice(collections): ...

# 3. пишешь тесты
mvn -pl 05-collections verify
git add 05-collections/src/test && git commit   # test(collections): ...

# 4. отвечаешь на вопросы самопроверки, отмечаешь тему
git commit -am "..."                            # review(collections): ... / docs: ...

git push -u origin HEAD
```

Дальше открываешь Pull Request в `main`, проходишь чек-лист из шаблона, ждёшь зелёный CI и мёрджишь **обычным merge commit**, не squash. Так в истории сохраняются все шаги темы.

## Issues, Milestones, Labels

- **Milestone** = модуль (`01-core`, `02-oop`, ...).
- **Issue** = тема. Заводится по шаблону `topic`. Номер issue указываешь в PR: `Closes #12`.
- **Labels:** `topic`, `project`, `review`, `stuck` (застрял, нужно вернуться), `rework` (конспект переписать).

Страница Projects в GitHub с колонками `Backlog → In progress → Review → Done` даёт визуальный прогресс.

## Теги

| Тег | Когда | Пример |
|-----|-------|--------|
| `m<NN>-done` | модуль закончен | `m01-done` |
| `week-<YYYY>-W<WW>` | конец недели (по желанию) | `week-2026-W43` |
| `<name>-v<X.Y.Z>` | релиз мини-проекта | `hangman-v1.0.0` |

```bash
git tag -a m01-done -m "Module 01-core complete"
git push origin m01-done
```

## Проекты

Мини-проект это Maven-модуль в `projects/<имя>/`. Теория закрепляется, когда из неё собрана работающая программа.

```bash
git checkout main && git pull
./scripts/new-project.sh hangman "Console Hangman game"
git checkout -b project/hangman-scaffold
git add projects && git commit    # project(hangman): add project scaffold
mvn -pl projects/hangman -am verify
```

**Порядок работы:**

1. В `projects/<имя>/README.md` запиши цель и список требований для версии 1.0.
2. Создай Milestone `project: <имя>`. Каждое требование = issue в этом milestone.
3. Одна фича = одна ветка `project/<имя>-<фича>` = один PR с `Closes #N`.
4. Коммиты: `project(<имя>): <что сделано>`, тесты отдельно: `test(<имя>): ...`.
5. Промежуточные версии (`0.2.0`, `0.3.0`) фиксируй в таблице «Вехи» в README проекта.

**Проект закончен, когда:**

- [ ] все требования из README выполнены, issues закрыты
- [ ] `mvn -pl projects/<имя> -am verify` зелёный, CI проходит
- [ ] запускается командой из раздела «Как запустить»
- [ ] заполнен раздел «Что я узнал»
- [ ] поставлен тег `<имя>-v1.0.0` и создан GitHub Release
- [ ] обновлены `docs/PROGRESS.md` и таблица в `projects/README.md`

```bash
git tag -a hangman-v1.0.0 -m "hangman 1.0.0"
git push origin hangman-v1.0.0
```

Проекты ведут параллельно с модулями, но не больше одного активного за раз.

## Ритм

**Каждый день (чек-лист):**
- [ ] Хотя бы один осмысленный коммит
- [ ] Код компилируется, тесты зелёные
- [ ] Записал, что осталось непонятным (в конспект, раздел «Вопросы»)

**Правило повторения 1-3-7:** через 1, 3 и 7 дней после темы открываешь конспект и отвечаешь на вопросы самопроверки, не подглядывая. Результат фиксируешь коммитом `review(scope): ...`.

**Каждое воскресенье (20–30 минут):**
```bash
./scripts/new-review.sh      # создаст docs/reviews/YYYY-Www.md
```
Заполняешь шаблон: что выучил, что неясно, метрики, план следующей недели. Коммит: `review: add weekly review 2026-W43`.

## Настройка GitHub (один раз)

1. Создай репозиторий `java-forge` (Public, без README: он уже есть).
2. Settings → General → Pull Requests: оставь только **Allow merge commits**, включи **Automatically delete head branches**.
3. Settings → Branches → защита `main`: требовать проходящий CI (статус `build`). Для одиночной работы approvals не нужны.
4. Создай Milestones по модулям и Labels из списка выше.

## Подводные камни

- Конспект не копия книги. Если не можешь объяснить своими словами, тема не закрыта.
- Не откладывай коммиты «на вечер»: теряется связь между кодом и тем, что ты тогда понял.
- Сломанный тест в `main` важнее новой темы. Сначала чини.
