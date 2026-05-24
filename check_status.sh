#!/bin/bash

# Путь к файлу отчета
LOG_FILE="deploy_status.log"
echo "=== Проверка статуса развертывания: $(date) ===" > $LOG_FILE

# 1. Тестируем локальный контейнер (из Упражнения 3.1)
LOCAL_URL="http://localhost:3000"
echo -n "Проверка локального сервера ($LOCAL_URL)... "
LOCAL_STATUS=$(curl -o /dev/null -s -w "%{http_code}" $LOCAL_URL)

if [ "$LOCAL_STATUS" -eq 200 ]; then
    echo "ОК (Код 200)" | tee -a $LOG_FILE
else
    echo "ОШИБКА (Код $LOCAL_STATUS)" | tee -a $LOG_FILE
fi

# 2. Тестируем облачный сервер Render (из Упражнения 3.2)
CLOUD_URL="https://express-pipeline-latest.onrender.com"
echo -n "Проверка облачного сервера ($CLOUD_URL)... "
CLOUD_STATUS=$(curl -o /dev/null -s -w "%{http_code}" $CLOUD_URL)

if [ "$CLOUD_STATUS" -eq 200 ]; then
    echo "ОК (Код 200)" | tee -a $LOG_FILE
else
    echo "ОШИБКА (Код $CLOUD_STATUS)" | tee -a $LOG_FILE
fi

echo "=== Проверка завершена ===" >> $LOG_FILE
echo "Результаты сохранены в $LOG_FILE"
