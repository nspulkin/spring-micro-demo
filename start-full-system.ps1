# PowerShell скрипт для запуска полной системы
Write-Host "========================================" -ForegroundColor Green
Write-Host "   Запуск полной системы с балансировкой" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Проверка портов перед запуском..." -ForegroundColor Yellow
Write-Host ""

# Проверка портов
$ports = @(8080, 8081, 8082, 8083, 8084, 8085)
$occupiedPorts = @()

foreach ($port in $ports) {
    $result = netstat -ano | Select-String ":$port"
    if ($result) {
        $occupiedPorts += $port
        Write-Host "❌ Порт $port ЗАНЯТ" -ForegroundColor Red
    } else {
        Write-Host "✅ Порт $port СВОБОДЕН" -ForegroundColor Green
    }
}

if ($occupiedPorts.Count -gt 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "    ОШИБКА: Некоторые порты заняты!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Для освобождения портов запустите:" -ForegroundColor Yellow
    Write-Host "stop-all-java.bat" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Или проверьте порты вручную:" -ForegroundColor Yellow
    Write-Host "check-ports.bat" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host "✅ Все порты свободны, начинаем запуск..." -ForegroundColor Green
Write-Host ""

# Запуск сервисов
Write-Host "1. Запуск Eureka Server..." -ForegroundColor Cyan
Start-Process -FilePath "cmd" -ArgumentList "/k", "cd eureka-server && gradlew bootRun" -WindowStyle Normal

Write-Host "Ожидание запуска Eureka Server (15 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

Write-Host ""
Write-Host "2. Запуск Eureka Client Instance 1 (порт 8082)..." -ForegroundColor Cyan
Start-Process -FilePath "cmd" -ArgumentList "/k", "cd eureka-client && gradlew bootRun --args='--spring.profiles.active=instance1'" -WindowStyle Normal

Write-Host "Ожидание запуска Instance 1 (5 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "3. Запуск Eureka Client Instance 2 (порт 8084)..." -ForegroundColor Cyan
Start-Process -FilePath "cmd" -ArgumentList "/k", "cd eureka-client && gradlew bootRun --args='--spring.profiles.active=instance2'" -WindowStyle Normal

Write-Host "Ожидание запуска Instance 2 (5 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "4. Запуск Eureka Client Instance 3 (порт 8085)..." -ForegroundColor Cyan
Start-Process -FilePath "cmd" -ArgumentList "/k", "cd eureka-client && gradlew bootRun --args='--spring.profiles.active=instance3'" -WindowStyle Normal

Write-Host "Ожидание запуска Instance 3 (5 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "5. Запуск Eureka Client 2 (порт 8083)..." -ForegroundColor Cyan
Start-Process -FilePath "cmd" -ArgumentList "/k", "cd eureka-client-2 && gradlew bootRun" -WindowStyle Normal

Write-Host "Ожидание запуска Eureka Client 2 (5 секунд)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "6. Запуск API Gateway..." -ForegroundColor Cyan
Start-Process -FilePath "cmd" -ArgumentList "/k", "cd api-gateway && gradlew bootRun" -WindowStyle Normal

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "    Полная система запущена!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Сервисы:" -ForegroundColor Yellow
Write-Host "- Eureka Server: http://localhost:8081/eureka/" -ForegroundColor White
Write-Host "- API Gateway: http://localhost:8080" -ForegroundColor White
Write-Host ""
Write-Host "Eureka Client экземпляры (балансировка нагрузки):" -ForegroundColor Yellow
Write-Host "- Instance 1: http://localhost:8082" -ForegroundColor White
Write-Host "- Instance 2: http://localhost:8084" -ForegroundColor White
Write-Host "- Instance 3: http://localhost:8085" -ForegroundColor White
Write-Host ""
Write-Host "Eureka Client 2: http://localhost:8083" -ForegroundColor White
Write-Host ""
Write-Host "Тестирование балансировки нагрузки:" -ForegroundColor Yellow
Write-Host "- http://localhost:8080/eureka-client/test" -ForegroundColor White
Write-Host "- http://localhost:8080/eureka-client/name" -ForegroundColor White
Write-Host "- http://localhost:8080/client/test" -ForegroundColor White
Write-Host "- http://localhost:8080/api/client/test" -ForegroundColor White
Write-Host ""
Write-Host "Откройте несколько раз один URL чтобы увидеть балансировку!" -ForegroundColor Green
Write-Host ""
Read-Host "Нажмите Enter для выхода"
