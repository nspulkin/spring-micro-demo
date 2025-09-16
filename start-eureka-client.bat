@echo off
echo Запуск Eureka Client...
cd eureka-client
start "Eureka Client" cmd /k "gradlew bootRun"
cd ..
echo Eureka Client запущен на порту 8082
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
pause
