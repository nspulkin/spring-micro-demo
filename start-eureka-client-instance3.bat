@echo off
echo ========================================
echo    Запуск Eureka Client Instance 3
echo ========================================
echo.

echo Запуск Eureka Client (Instance 3) на порту 8085...
cd eureka-client
start "Eureka Client Instance 3" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance3'"
cd ..

echo.
echo Eureka Client Instance 3 запущен на порту 8085
echo Profile: instance3
echo Instance ID: eureka-client:instance3:8085
echo.
echo Тестовые эндпоинты:
echo - http://localhost:8085/test
echo - http://localhost:8085/name
echo - http://localhost:8085/main/test
echo - http://localhost:8085/main/health
echo.
echo Через API Gateway (балансировка нагрузки):
echo - http://localhost:8080/eureka-client/test
echo - http://localhost:8080/eureka-client/name
echo - http://localhost:8080/client/test
echo - http://localhost:8080/api/client/test
echo.
pause
