@echo off
echo ========================================
echo    Остановка всех Java процессов
echo ========================================
echo.

echo Останавливаем все Java процессы...
taskkill /F /IM java.exe

if %errorlevel% equ 0 (
    echo ✅ Все Java процессы успешно остановлены
) else (
    echo ⚠️  Нет запущенных Java процессов или ошибка остановки
)

echo.
echo Проверка освобождения портов...
timeout /t 2 /nobreak > nul

echo.
echo Порт 8080 (API Gateway):
netstat -ano | findstr :8080
if %errorlevel% equ 0 (
    echo ❌ Порт 8080 все еще занят
) else (
    echo ✅ Порт 8080 освобожден
)

echo.
echo Порт 8081 (Eureka Server):
netstat -ano | findstr :8081
if %errorlevel% equ 0 (
    echo ❌ Порт 8081 все еще занят
) else (
    echo ✅ Порт 8081 освобожден
)

echo.
echo Порт 8082 (Eureka Client):
netstat -ano | findstr :8082
if %errorlevel% equ 0 (
    echo ❌ Порт 8082 все еще занят
) else (
    echo ✅ Порт 8082 освобожден
)

echo.
echo Порт 8083 (Eureka Client 2):
netstat -ano | findstr :8083
if %errorlevel% equ 0 (
    echo ❌ Порт 8083 все еще занят
) else (
    echo ✅ Порт 8083 освобожден
)

echo.
echo ========================================
echo    Готово!
echo ========================================
echo.
echo Теперь можно запускать сервисы:
echo - start-eureka-server.bat
echo - start-eureka-client.bat
echo - start-eureka-client-2.bat
echo - start-api-gateway.bat
echo.
pause
