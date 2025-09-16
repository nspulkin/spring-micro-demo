@echo off
echo ========================================
echo    Запуск всех микросервисов
echo ========================================

echo.
echo 1. Запуск Eureka Server...
start "Eureka Server" cmd /k "cd eureka-server && gradlew bootRun"

echo Ожидание запуска Eureka Server (15 секунд)...
timeout /t 15 /nobreak > nul

echo.
echo 2. Запуск Eureka Client...
start "Eureka Client" cmd /k "cd eureka-client && gradlew bootRun"

echo Ожидание запуска Eureka Client (10 секунд)...
timeout /t 10 /nobreak > nul

echo.
echo 3. Запуск Eureka Client 2...
start "Eureka Client 2" cmd /k "cd eureka-client-2 && gradlew bootRun"

echo Ожидание запуска Eureka Client 2 (10 секунд)...
timeout /t 10 /nobreak > nul

echo.
echo 4. Запуск API Gateway...
start "API Gateway" cmd /k "cd api-gateway && gradlew bootRun"

echo.
echo ========================================
echo    Все сервисы запущены!
echo ========================================
echo.
echo Адреса для проверки:
echo - Eureka Dashboard: http://localhost:8081/eureka/
echo - API Gateway: http://localhost:8080
echo - Eureka Client: http://localhost:8082
echo - Eureka Client 2: http://localhost:8083
echo.
echo Тестовые эндпоинты через Gateway:
echo - http://localhost:8080/gateway/status
echo - http://localhost:8080/eureka-client/test
echo - http://localhost:8080/eureka-client/name
echo - http://localhost:8080/eureka-client-2/test
echo - http://localhost:8080/eureka-client-2/name
echo - http://localhost:8080/gateway/usage
echo.
pause
