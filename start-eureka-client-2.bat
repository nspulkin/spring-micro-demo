@echo off
echo Запуск Eureka Client 2...
cd eureka-client-2
start "Eureka Client 2" cmd /k "gradlew bootRun"
cd ..
echo Eureka Client 2 запущен на порту 8083
echo Тестовые эндпоинты:
echo - http://localhost:8083/test
echo - http://localhost:8083/name
echo - http://localhost:8083/new/name
echo - http://localhost:8083/new/health
echo.
echo Через API Gateway:
echo - http://localhost:8080/eureka-client-2/test
echo - http://localhost:8080/eureka-client-2/name
echo - http://localhost:8080/client2/test
echo - http://localhost:8080/api/client2/test
pause
