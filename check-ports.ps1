# PowerShell скрипт для проверки портов
Write-Host "========================================" -ForegroundColor Green
Write-Host "    Проверка портов проекта" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Проверка портов проекта..." -ForegroundColor Yellow
Write-Host ""

# Список портов для проверки
$ports = @(
    @{Port=8080; Name="API Gateway"},
    @{Port=8081; Name="Eureka Server"},
    @{Port=8082; Name="Eureka Client Instance 1"},
    @{Port=8083; Name="Eureka Client 2"},
    @{Port=8084; Name="Eureka Client Instance 2"},
    @{Port=8085; Name="Eureka Client Instance 3"}
)

foreach ($portInfo in $ports) {
    Write-Host "Порт $($portInfo.Port) ($($portInfo.Name)):" -ForegroundColor Cyan
    $result = netstat -ano | Select-String ":$($portInfo.Port)"
    if ($result) {
        Write-Host "❌ Порт $($portInfo.Port) ЗАНЯТ" -ForegroundColor Red
    } else {
        Write-Host "✅ Порт $($portInfo.Port) СВОБОДЕН" -ForegroundColor Green
    }
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "    Java процессы" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
$javaProcesses = Get-Process -Name "java" -ErrorAction SilentlyContinue
if ($javaProcesses) {
    $javaProcesses | Format-Table ProcessName, Id, CPU -AutoSize
} else {
    Write-Host "Нет запущенных Java процессов" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "Для остановки всех Java процессов используйте:" -ForegroundColor Yellow
Write-Host "stop-all-java.bat" -ForegroundColor White
Write-Host ""
Read-Host "Нажмите Enter для выхода"
