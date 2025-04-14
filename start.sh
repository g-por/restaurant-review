#!/usr/bin/env bash

echo "Зупинка попередніх контейнерів..."
docker-compose down

echo "Збірка образів і запуск..."
docker-compose up --build -d

echo "Запущено:"
docker ps
