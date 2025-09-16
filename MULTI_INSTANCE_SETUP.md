# Настройка нескольких экземпляров Eureka Client

## 🎯 Цель
Возможность запуска нескольких экземпляров `eureka-client` для тестирования балансировки нагрузки и отказоустойчивости.

## 📋 Конфигурация экземпляров

### Экземпляры Eureka Client:

| Экземпляр | Порт | Профиль | Instance ID |
|-----------|------|---------|-------------|
| Instance 1 | 8082 | instance1 | eureka-client:instance1:8082 |
| Instance 2 | 8084 | instance2 | eureka-client:instance2:8084 |
| Instance 3 | 8085 | instance3 | eureka-client:instance3:8085 |

### Другие сервисы:

| Сервис | Порт | Назначение |
|--------|------|------------|
| Eureka Server | 8081 | Сервер обнаружения |
| Eureka Client 2 | 8083 | Второй клиентский сервис |
| API Gateway | 8080 | Балансировка нагрузки |

## 🚀 Скрипты запуска

### Отдельные экземпляры:
- `start-eureka-client-instance1.bat` - Instance 1 (порт 8082)
- `start-eureka-client-instance2.bat` - Instance 2 (порт 8084)
- `start-eureka-client-instance3.bat` - Instance 3 (порт 8085)

### Групповые скрипты:
- `start-all-eureka-client-instances.bat` - Все экземпляры eureka-client
- `start-full-system.bat` - Вся система с балансировкой

## 🔧 Файлы конфигурации

### Профили eureka-client:
- `application.properties` - Конфигурация по умолчанию (порт 8082)
- `application-instance1.properties` - Instance 1 (порт 8082)
- `application-instance2.properties` - Instance 2 (порт 8084)
- `application-instance3.properties` - Instance 3 (порт 8085)

### Ключевые настройки:
```properties
server.port=808X
spring.application.name=eureka-client
spring.profiles.active=instanceX
eureka.instance.instance-id=${spring.application.name}:${spring.profiles.active}:${server.port}
```

## 🌐 Балансировка нагрузки

### API Gateway автоматически:
- Обнаруживает все экземпляры `eureka-client`
- Распределяет запросы между экземплярами
- Обеспечивает отказоустойчивость

### Тестирование балансировки:
```
# Откройте несколько раз:
http://localhost:8080/eureka-client/test
http://localhost:8080/eureka-client/name
http://localhost:8080/client/test
http://localhost:8080/api/client/test
```

## 📊 Мониторинг

### Eureka Dashboard:
- URL: http://localhost:8081/eureka/
- Показывает все зарегистрированные экземпляры
- Отображает статус каждого экземпляра

### Прямые вызовы:
- Instance 1: http://localhost:8082/test
- Instance 2: http://localhost:8084/test
- Instance 3: http://localhost:8085/test

## ⚠️ Важные моменты

### Порядок запуска:
1. Eureka Server (8081)
2. Eureka Client экземпляры (8082, 8084, 8085)
3. Eureka Client 2 (8083)
4. API Gateway (8080)

### Проверка портов:
- Используйте `check-ports.bat` для проверки
- Используйте `stop-all-java.bat` для остановки

### Уникальные Instance ID:
- Каждый экземпляр имеет уникальный ID
- Формат: `eureka-client:profile:port`
- Позволяет различать экземпляры в Eureka

## ✅ Преимущества

1. **Балансировка нагрузки** - запросы распределяются между экземплярами
2. **Отказоустойчивость** - при падении одного экземпляра остальные продолжают работать
3. **Масштабируемость** - легко добавить больше экземпляров
4. **Тестирование** - можно тестировать поведение при разных нагрузках

## 🎯 Результат

Теперь можно запускать несколько экземпляров `eureka-client` и наблюдать, как API Gateway автоматически распределяет нагрузку между ними!
