#!/usr/bin/env bash
# Создаёт новый мини-проект: Maven-модуль projects/<имя> с README, кодом и тестом,
# и сам подключает его в projects/pom.xml.
#
# Использование:
#   ./scripts/new-project.sh <имя-проекта> ["описание"]
# Пример:
#   ./scripts/new-project.sh tasks-cli "CLI task manager"
set -euo pipefail
shopt -u patsub_replacement 2>/dev/null || true

usage() {
  echo "Использование: $0 <имя-проекта> [\"описание\"]"
  echo "Имя: латиница, цифры и дефисы, начинается с буквы (например: tasks-cli)"
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

NAME="$1"
shift
DESC="${*:-}"

if ! [[ "$NAME" =~ ^[a-z][a-z0-9]*(-[a-z0-9]+)*$ ]] || [ "${#NAME}" -gt 30 ]; then
  echo "Неверное имя проекта: $NAME"
  usage
  exit 1
fi

# Имя пакета = имя без дефисов. Ключевые слова Java использовать нельзя.
PKGNAME="$(echo "$NAME" | tr -d '-')"
case "$PKGNAME" in
  abstract|assert|boolean|break|byte|case|catch|char|class|const|continue|default|do|double|else|enum|extends|final|finally|float|for|goto|if|implements|import|instanceof|int|interface|long|native|new|package|private|protected|public|return|short|static|strictfp|super|switch|synchronized|this|throw|throws|transient|try|void|volatile|while|true|false|null)
    echo "Имя '$NAME' даёт пакет с ключевым словом Java ($PKGNAME). Выбери другое имя."
    exit 1
    ;;
esac

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS="$ROOT/projects"
DIR="$PROJECTS/$NAME"
PKG="dev.journey.projects.$PKGNAME"
PKG_DIR="dev/journey/projects/$PKGNAME"
DATE="$(date +%F)"
MARKER="new-project.sh добавляет модули ниже этой строки"

# Все проверки до создания файлов, чтобы не оставить полупустой проект
[ -f "$PROJECTS/pom.xml" ] || { echo "Не найден projects/pom.xml"; exit 1; }
grep -q "$MARKER" "$PROJECTS/pom.xml" || { echo "В projects/pom.xml нет строки-маркера для модулей"; exit 1; }
[ ! -e "$DIR" ] || { echo "Проект уже существует: $DIR"; exit 1; }
[ -f "$ROOT/docs/templates/project-readme.md" ] || { echo "Не найден шаблон docs/templates/project-readme.md"; exit 1; }

mkdir -p "$DIR/src/main/java/$PKG_DIR" "$DIR/src/test/java/$PKG_DIR"

cat > "$DIR/pom.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <parent>
    <groupId>dev.journey</groupId>
    <artifactId>projects</artifactId>
    <version>1.0-SNAPSHOT</version>
  </parent>

  <artifactId>${NAME}</artifactId>
  <name>projects/${NAME}</name>

  <build>
    <finalName>\${project.artifactId}</finalName>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-jar-plugin</artifactId>
        <configuration>
          <archive>
            <manifest>
              <mainClass>${PKG}.Main</mainClass>
            </manifest>
          </archive>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
EOF

cat > "$DIR/src/main/java/$PKG_DIR/Main.java" <<EOF
package ${PKG};

public final class Main {

    private Main() {
    }

    static String greeting() {
        return "Hello from ${NAME}";
    }

    public static void main(String[] args) {
        System.out.println(greeting());
    }
}
EOF

cat > "$DIR/src/test/java/$PKG_DIR/MainTest.java" <<EOF
package ${PKG};

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class MainTest {

    @Test
    void greetingMentionsProjectName() {
        assertThat(Main.greeting()).contains("${NAME}");
    }
}
EOF

# README проекта из шаблона
content="$(cat "$ROOT/docs/templates/project-readme.md")"
content="${content//\{\{NAME\}\}/$NAME}"
content="${content//\{\{DESC\}\}/$DESC}"
content="${content//\{\{DATE\}\}/$DATE}"
printf '%s\n' "$content" > "$DIR/README.md"

# Подключаем модуль в projects/pom.xml сразу после маркера
tmp="$(mktemp)"
awk -v marker="$MARKER" -v line="    <module>${NAME}</module>" '
  { print }
  index($0, marker) { print line }
' "$PROJECTS/pom.xml" > "$tmp"
cat "$tmp" > "$PROJECTS/pom.xml"
rm -f "$tmp"

echo "Проект создан: projects/$NAME"
echo "  README.md, pom.xml, Main.java, MainTest.java"
echo "  модуль подключён в projects/pom.xml"
echo
echo "Дальше:"
echo "  1. Заполни цель и требования в projects/$NAME/README.md"
echo "  2. git checkout -b project/$NAME-scaffold"
echo "  3. git add projects && git commit -m \"project($NAME): add project scaffold\""
echo "  4. Добавь строку проекта в таблицу «Проекты» в docs/PROGRESS.md"
echo
echo "Проверка: mvn -pl projects/$NAME -am verify"
