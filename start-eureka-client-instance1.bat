@echo off
echo ========================================
echo    Запуск Eureka Client Instance 1
echo ========================================
echo.

echo Запуск Eureka Client (Instance 1) на порту 8082...
cd eureka-client
start "Eureka Client Instance 1" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance1'"
cd ..

echo.
echo Eureka Client Instance 1 запущен на порту 8082
echo Profile: instance1
echo Instance ID: eureka-client:instance1:8082
echo.
echo Тестовые эндпоинты:
echo - http://localhost:8082/test
echo - http://localhost:8082/name
echo - http://localhost:8082/main/test
echo - http://localhost:8082/main/health
echo.
echo Через API Gateway:
echo - http://localhost:8080/eureka-client/test
echo - http://localhost:8080/eureka-client/name
echo - http://localhost:8080/client/test
echo - http://localhost:8080/api/client/test
echo.
pause
