@echo off
echo ========================================
echo    Запуск всех экземпляров Eureka Client
echo ========================================
echo.

echo Проверка портов перед запуском...
echo.

set /a port_8082=0
set /a port_8084=0
set /a port_8085=0

netstat -ano | findstr :8082 > nul
if %errorlevel% equ 0 set /a port_8082=1

netstat -ano | findstr :8084 > nul
if %errorlevel% equ 0 set /a port_8084=1

netstat -ano | findstr :8085 > nul
if %errorlevel% equ 0 set /a port_8085=1

if %port_8082% equ 1 (
    echo ❌ Порт 8082 (Instance 1) ЗАНЯТ
    goto :error
)
if %port_8084% equ 1 (
    echo ❌ Порт 8084 (Instance 2) ЗАНЯТ
    goto :error
)
if %port_8085% equ 1 (
    echo ❌ Порт 8085 (Instance 3) ЗАНЯТ
    goto :error
)

echo ✅ Все порты свободны, начинаем запуск...
echo.

echo 1. Запуск Eureka Client Instance 1 (порт 8082)...
cd eureka-client
start "Eureka Client Instance 1" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance1'"
cd ..

echo Ожидание запуска Instance 1 (5 секунд)...
timeout /t 5 /nobreak > nul

echo.
echo 2. Запуск Eureka Client Instance 2 (порт 8084)...
cd eureka-client
start "Eureka Client Instance 2" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance2'"
cd ..

echo Ожидание запуска Instance 2 (5 секунд)...
timeout /t 5 /nobreak > nul

echo.
echo 3. Запуск Eureka Client Instance 3 (порт 8085)...
cd eureka-client
start "Eureka Client Instance 3" cmd /k "gradlew bootRun --args='--spring.profiles.active=instance3'"
cd ..

echo.
echo ========================================
echo    Все экземпляры Eureka Client запущены!
echo ========================================
echo.
echo Экземпляры:
echo - Instance 1: http://localhost:8082 (profile: instance1)
echo - Instance 2: http://localhost:8084 (profile: instance2)
echo - Instance 3: http://localhost:8085 (profile: instance3)
echo.
echo Через API Gateway (балансировка нагрузки):
echo - http://localhost:8080/eureka-client/test
echo - http://localhost:8080/eureka-client/name
echo - http://localhost:8080/client/test
echo - http://localhost:8080/api/client/test
echo.
echo Проверка балансировки:
echo - Откройте несколько раз: http://localhost:8080/eureka-client/test
echo - Вы увидите ответы от разных экземпляров!
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
