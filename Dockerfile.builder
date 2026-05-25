FROM docker:latest

# Устанавливаем git, так как базовый образ docker его не содержит
RUN apk add --no-cache git

# Копируем наш локальный скрипт внутрь контейнера
COPY builder.sh /builder.sh

# Делаем скрипт исполняемым внутри файловой системы контейнера
RUN chmod +x /builder.sh

# Задаем точку входа, принимающую внешние аргументы командной строки
ENTRYPOINT ["/builder.sh"]
