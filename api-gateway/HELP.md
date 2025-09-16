# API Gateway

Этот модуль представляет собой API Gateway для микросервисной архитектуры.

## Функциональность

- Автоматическое обнаружение сервисов через Eureka
- Маршрутизация запросов к микросервисам без указания ID приложения
- Балансировка нагрузки
- Единая точка входа для всех API
- Универсальные маршруты для любых сервисов

## Маршруты

### Прямые маршруты сервисов:
- `/eureka-client/**` → перенаправляется в `eureka-client`
- `/api/client/**` → перенаправляется в `eureka-client`

### Универсальные маршруты:
- `/{service-name}/**` → автоматически перенаправляется в сервис с именем `{service-name}`

### Внутренние эндпоинты Gateway:
- `/gateway/status` → статус Gateway
- `/gateway/services` → список зарегистрированных сервисов
- `/gateway/info` → подробная информация о Gateway
- `/gateway/usage` → примеры использования

## Примеры использования

### Вызов eureka-client:
```
GET http://localhost:8080/eureka-client/test
GET http://localhost:8080/eureka-client/health
GET http://localhost:8080/api/client/test
```

### Универсальный вызов любого сервиса:
```
GET http://localhost:8080/{service-name}/{endpoint}
```

## Порт

Gateway работает на порту 8080
