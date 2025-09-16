@echo off
echo Запуск Eureka Client...
cd eureka-client
start "Eureka Client" cmd /k "gradlew bootRun"
cd ..
echo Eureka Client запущен на порту 8082
echo Тестовые эндпоинты:
echo - http://localhost:8082/test
echo - http://localhost:8082/health
pause
