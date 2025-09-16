@echo off
echo Запуск API Gateway...
cd api-gateway
start "API Gateway" cmd /k "gradlew bootRun"
cd ..
echo API Gateway запущен на порту 8080
echo.
echo ========================================
echo    Примеры использования API Gateway
echo ========================================
echo.
echo 1. Прямые вызовы сервисов:
echo    http://localhost:8080/eureka-client/test
echo    http://localhost:8080/eureka-client/health
echo.
echo 2. API маршруты:
echo    http://localhost:8080/api/client/test
echo    http://localhost:8080/api/client/health
echo.
echo 3. Универсальные маршруты (для любых сервисов):
echo    http://localhost:8080/{service-name}/{endpoint}
echo.
echo 4. Информация о Gateway:
echo    http://localhost:8080/gateway/info
echo    http://localhost:8080/gateway/services
echo    http://localhost:8080/gateway/usage
echo.
pause
