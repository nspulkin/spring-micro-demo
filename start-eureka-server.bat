@echo off
echo Запуск Eureka Server...
cd eureka-server
start "Eureka Server" cmd /k "gradlew bootRun"
cd ..
echo Eureka Server запущен на порту 8081
echo Панель управления доступна по адресу: http://localhost:8081/eureka/
pause
