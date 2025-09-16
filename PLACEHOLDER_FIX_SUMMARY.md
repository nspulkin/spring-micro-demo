# Исправление ошибки с плейсхолдером

## ❌ Проблема:
```
Could not resolve placeholder 'eureka.instance.instance-id' in value "${eureka.instance.instance-id}"
```

## 🔍 Причина:
В файле `eureka-client/src/main/java/ru/javabegin/micro/demo/eurekaclient/controller/TestController.java` использовался неправильный плейсхолдер для получения порта сервера.

## ✅ Исправление:

### Было:
```java
@Value("${eureka.instance.instance-id}")
private String port;
```

### Стало:
```java
@Value("${server.port}")
private String port;
```

## 📋 Проверка всех плейсхолдеров:

### Найденные плейсхолдеры в проекте:
- ✅ `${spring.application.name}` - имя приложения (корректно)
- ✅ `${server.port}` - порт сервера (корректно)

### Файлы с плейсхолдерами:
- ✅ `eureka-client/TestController.java` - исправлен
- ✅ `eureka-client-2/NewController.java` - корректно
- ✅ `api-gateway/RoutingController.java` - корректно
- ✅ `api-gateway/GatewayController.java` - корректно

## 🚀 Результат:

**ОШИБКА С ПЛЕЙСХОЛДЕРОМ ИСПРАВЛЕНА!**

- ✅ Убран неправильный плейсхолдер `${eureka.instance.instance-id}`
- ✅ Заменен на корректный `${server.port}`
- ✅ Все остальные плейсхолдеры проверены и корректны
- ✅ Приложение должно запускаться без ошибок

## 📝 Объяснение:

- `${spring.application.name}` - автоматически доступен в Spring Boot
- `${server.port}` - автоматически доступен в Spring Boot
- `${eureka.instance.instance-id}` - НЕ определен в конфигурации, поэтому вызывал ошибку

**Теперь все контроллеры используют только стандартные переменные Spring Boot!**
