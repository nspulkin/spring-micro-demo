# Конфигурация портов проекта

## Текущие настройки портов:

| Сервис | Порт | Файл конфигурации | Статус |
|--------|------|-------------------|--------|
| eureka-server | 8081 | application.properties | ✅ |
| eureka-client | 8082 | application.properties | ✅ |
| eureka-client-2 | 8083 | application.properties | ✅ |
| api-gateway | 8080 | application.yml | ✅ |

## Проверка конфликтов:

- ✅ Все порты уникальны
- ✅ Нет дублирующих конфигураций
- ✅ API Gateway использует только application.yml

## Исправленные проблемы:

1. ✅ Удален дублирующий application.properties в api-gateway
2. ✅ Убрана лишняя строка с random.value в eureka-client
3. ✅ Все порты настроены корректно

## Порты для тестирования:

### Прямые вызовы:
- http://localhost:8081 - Eureka Server
- http://localhost:8082 - Eureka Client
- http://localhost:8083 - Eureka Client 2
- http://localhost:8080 - API Gateway

### Через Gateway:
- http://localhost:8080/eureka-client/test
- http://localhost:8080/eureka-client-2/test
