#!/bin/sh

# Проверяем наличие двух обязательных аргументов
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Ошибка: Передайте аргументы: <github_repo_url> <docker_hub_image>"
  exit 1
fi

REPO_URL=$1
IMAGE_NAME=$2

# Проверяем наличие переменных окружения с паролями
if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PWD" ]; then
  echo "Ошибка: Переменные окружения DOCKER_USER и DOCKER_PWD должны быть заданы!"
  exit 1
fi

# 1. Клонируем проект во временную папку
echo "=== Клонирование репозитория: $REPO_URL ==="
rm -rf temp_app
git clone "$REPO_URL" temp_app
cd temp_app || exit 1

# 2. Авторизуемся в Docker Hub
echo "=== Авторизация в Docker Hub ==="
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

# 3. Собираем образ из Dockerfile, который лежит в корне клонированного проекта
echo "=== Сборка Docker-образа: $IMAGE_NAME ==="
docker build -t "$IMAGE_NAME" .

# 4. Пушим готовый образ в облачный реестр
echo "=== Пуш образа в Docker Hub ==="
docker push "$IMAGE_NAME"

# Очищаем за собой рабочую директорию
cd ..
rm -rf temp_app
echo "=== Сборка и публикация успешно завершены! ==="
