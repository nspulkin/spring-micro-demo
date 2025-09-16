@echo off
echo ========================================
echo    Запуск полной системы с балансировкой
echo ========================================
echo.

echo Проверка портов перед запуском...
echo.

set /a port_8080=0
set /a port_8081=0
set /a port_8082=0
set /a port_8083=0
set /a port_8084=0
set /a port_8085=0

netstat -ano | findstr :8080 > nul
if %errorlevel% equ 0 set /a port_8080=1

netstat -ano | findstr :8081 > nul
if %errorlevel% equ 0 set /a port_8081=1

netstat -ano | findstr :8082 > nul
if %errorlevel% equ 0 set /a port_8082=1

netstat -ano | findstr :8083 > nul
if %errorlevel% equ 0 set /a port_8083=1

netstat -ano | findstr :8084 > nul
if %errorlevel% equ 0 set /a port_8084=1

netstat -ano | findstr :8085 > nul
if %errorlevel% equ 0 set /a port_8085=1

if %port_8080% equ 1 (
    echo ❌ Порт 8080 (API Gateway) ЗАНЯТ
    goto :error
)
if %port_8081% equ 1 (
    echo ❌ Порт 8081 (Eureka Server) ЗАНЯТ
    goto :error
)
if %port_8082% equ 1 (
    echo ❌ Порт 8082 (Eureka Client Instance 1) ЗАНЯТ
    goto :error
)
if %port_8083% equ 1 (
    echo ❌ Порт 8083 (Eureka Client 2) ЗАНЯТ
    goto :error
)
if %port_8084% equ 1 (
    echo ❌ Порт 8084 (Eureka Client Instance 2) ЗАНЯТ
    goto :error
)
if %port_8085% equ 1 (
    echo ❌ Порт 8085 (Eureka Client Instance 3) ЗАНЯТ
    goto :error
)

echo ✅ Все порты свободны, начинаем запуск...
echo.

echo 1. Запуск Eureka Server...
start "Eureka Server" cmd /k "cd eureka-server && gradlew bootRun"

echo Ожидание запуска Eureka Server (15 секунд)...
timeout /t 15 /nobreak > nul

echo.
echo 2. Запуск Eureka Client Instance 1 (порт 8082)...
cd eureka-client
start "Eureka Client Instance 1" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance1'"
cd ..

echo Ожидание запуска Instance 1 (5 секунд)...
timeout /t 5 /nobreak > nul

echo.
echo 3. Запуск Eureka Client Instance 2 (порт 8084)...
cd eureka-client
start "Eureka Client Instance 2" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance2'"
cd ..

echo Ожидание запуска Instance 2 (5 секунд)...
timeout /t 5 /nobreak > nul

echo.
echo 4. Запуск Eureka Client Instance 3 (порт 8085)...
cd eureka-client
start "Eureka Client Instance 3" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance3'"
cd ..

echo Ожидание запуска Instance 3 (5 секунд)...
timeout /t 5 /nobreak > nul

echo.
echo 5. Запуск Eureka Client 2 (порт 8083)...
start "Eureka Client 2" cmd /k "cd eureka-client-2 && gradlew bootRun"

echo Ожидание запуска Eureka Client 2 (5 секунд)...
timeout /t 5 /nobreak > nul

echo.
echo 6. Запуск API Gateway...
start "API Gateway" cmd /k "cd api-gateway && gradlew bootRun"

echo.
echo ========================================
echo    Полная система запущена!
echo ========================================
echo.
echo Сервисы:
echo - Eureka Server: http://localhost:8081/eureka/
echo - API Gateway: http://localhost:8080
echo.
echo Eureka Client экземпляры (балансировка нагрузки):
echo - Instance 1: http://localhost:8082
echo - Instance 2: http://localhost:8084
echo - Instance 3: http://localhost:8085
echo.
echo Eureka Client 2: http://localhost:8083
echo.
echo Тестирование балансировки нагрузки:
echo - http://localhost:8080/eureka-client/test
echo - http://localhost:8080/eureka-client/name
echo - http://localhost:8080/client/test
echo - http://localhost:8080/api/client/test
echo.
echo Откройте несколько раз один URL чтобы увидеть балансировку!
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
pause
