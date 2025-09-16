@echo off
echo ========================================
echo    Запуск Eureka Client Instance 2
echo ========================================
echo.

echo Запуск Eureka Client (Instance 2) на порту 8084...
cd eureka-client
start "Eureka Client Instance 2" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance2'"
cd ..

echo.
echo Eureka Client Instance 2 запущен на порту 8084
echo Profile: instance2
echo Instance ID: eureka-client:instance2:8084
echo.
echo Тестовые эндпоинты:
echo - http://localhost:8084/test
echo - http://localhost:8084/name
echo - http://localhost:8084/main/test
echo - http://localhost:8084/main/health
echo.
echo Через API Gateway (балансировка нагрузки):
echo - http://localhost:8080/eureka-client/test
echo - http://localhost:8080/eureka-client/name
echo - http://localhost:8080/client/test
echo - http://localhost:8080/api/client/test
echo.
pause
