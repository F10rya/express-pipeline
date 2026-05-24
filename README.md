# Express CI/CD Pipeline Project

Учебный проект по настройке конвейера непрерывной интеграции (CI) и непрерывной доставки (CD) для Node.js/Express приложения с использованием современных DevOps-инструментов.

## Ссылки на развертывание
* **Production (Удаленный сервер):** [https://express-pipeline-latest.onrender.com](https://express-pipeline-latest.onrender.com)
* **Docker Hub Репозиторий:** [https://hub.docker.com/r/f10rya/express-pipeline](https://hub.docker.com/r/f10rya/express-pipeline)

## Архитектура конвейера
1. **CI (GitHub Actions):** При каждом пуше в ветку `main` автоматически запускается сборка Docker-образа на базе `Dockerfile` и его публикация в Docker Hub.
2. **CD Локально (Docker Compose & Watchtower):** Локальный запуск контейнера из облачного реестра. Утилита Watchtower автоматически отслеживает новые теги образа на Docker Hub и обновляет локальный контейнер.
3. **CD в Облако (Render Webhook):** GitHub через Webhook уведомляет платформу Render о сборке нового образа, запуская автоматический передеплой веб-сервиса.

## Инструкция по локальному запуску

1. Склонируйте репозиторий:
   ```bash
   git clone [https://github.com/F10rya/express-pipeline.git](https://github.com/F10rya/express-pipeline.git)
   cd express-pipeline
