@echo off
echo ========================================
echo    Проверка портов проекта
echo ========================================
echo.

echo Проверка портов проекта...
echo.

echo Порт 8080 (API Gateway):
netstat -ano | findstr :8080
if %errorlevel% equ 0 (
    echo ❌ Порт 8080 ЗАНЯТ
) else (
    echo ✅ Порт 8080 СВОБОДЕН
)
echo.

echo Порт 8081 (Eureka Server):
netstat -ano | findstr :8081
if %errorlevel% equ 0 (
    echo ❌ Порт 8081 ЗАНЯТ
) else (
    echo ✅ Порт 8081 СВОБОДЕН
)
echo.

echo Порт 8082 (Eureka Client Instance 1):
netstat -ano | findstr :8082
if %errorlevel% equ 0 (
    echo ❌ Порт 8082 ЗАНЯТ
) else (
    echo ✅ Порт 8082 СВОБОДЕН
)
echo.

echo Порт 8083 (Eureka Client 2):
netstat -ano | findstr :8083
if %errorlevel% equ 0 (
    echo ❌ Порт 8083 ЗАНЯТ
) else (
    echo ✅ Порт 8083 СВОБОДЕН
)
echo.

echo Порт 8084 (Eureka Client Instance 2):
netstat -ano | findstr :8084
if %errorlevel% equ 0 (
    echo ❌ Порт 8084 ЗАНЯТ
) else (
    echo ✅ Порт 8084 СВОБОДЕН
)
echo.

echo Порт 8085 (Eureka Client Instance 3):
netstat -ano | findstr :8085
if %errorlevel% equ 0 (
    echo ❌ Порт 8085 ЗАНЯТ
) else (
    echo ✅ Порт 8085 СВОБОДЕН
)
echo.

echo ========================================
echo    Java процессы
echo ========================================
tasklist | findstr java
echo.

echo Для остановки всех Java процессов используйте:
echo taskkill /F /IM java.exe
echo.
pause
