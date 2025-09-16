@echo off
echo ========================================
echo    Безопасный запуск всех сервисов
echo ========================================
echo.

echo Проверка портов перед запуском...
echo.

set /a port_8080=0
set /a port_8081=0
set /a port_8082=0
set /a port_8083=0

netstat -ano | findstr :8080 > nul
if %errorlevel% equ 0 set /a port_8080=1

netstat -ano | findstr :8081 > nul
if %errorlevel% equ 0 set /a port_8081=1

netstat -ano | findstr :8082 > nul
if %errorlevel% equ 0 set /a port_8082=1

netstat -ano | findstr :8083 > nul
if %errorlevel% equ 0 set /a port_8083=1

if %port_8080% equ 1 (
    echo ❌ Порт 8080 (API Gateway) ЗАНЯТ
    goto :error
)
if %port_8081% equ 1 (
    echo ❌ Порт 8081 (Eureka Server) ЗАНЯТ
    goto :error
)
if %port_8082% equ 1 (
    echo ❌ Порт 8082 (Eureka Client) ЗАНЯТ
    goto :error
)
if %port_8083% equ 1 (
    echo ❌ Порт 8083 (Eureka Client 2) ЗАНЯТ
    goto :error
)

echo ✅ Все порты свободны, начинаем запуск...
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
goto :end

:error
echo.
echo ========================================
echo    ОШИБКА: Некоторые порты заняты!
echo ========================================
echo.
echo Для освобождения портов запустите:
echo stop-all-java.bat
echo.
echo Или проверьте порты вручную:
echo check-ports.bat
echo.
pause
exit /b 1

:end
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
