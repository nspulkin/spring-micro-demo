package ru.javabegin.micro.demo.apigateway.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
public class RoutingController {

    private final DiscoveryClient discoveryClient;

    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${server.port}")
    private String port;

    public RoutingController(DiscoveryClient discoveryClient) {
        this.discoveryClient = discoveryClient;
    }

    @GetMapping("/gateway/info")
    public Mono<Map<String, Object>> getGatewayInfo() {
        Map<String, Object> info = new HashMap<>();
        info.put("gateway", applicationName);
        info.put("port", port);
        info.put("status", "active");
        
        List<String> services = discoveryClient.getServices();
        info.put("discoveredServices", services);
        
        Map<String, String> routes = new HashMap<>();
        routes.put("/eureka-client/**", "lb://eureka-client (порт 8082)");
        routes.put("/client/**", "lb://eureka-client");
        routes.put("/api/client/**", "lb://eureka-client");
        routes.put("/eureka-client-2/**", "lb://eureka-client-2 (порт 8083)");
        routes.put("/client2/**", "lb://eureka-client-2");
        routes.put("/api/client2/**", "lb://eureka-client-2");
        routes.put("/{serviceId}/**", "Автоматические маршруты через Discovery Locator");
        info.put("availableRoutes", routes);
        
        return Mono.just(info);
    }

    @GetMapping("/gateway/usage")
    public Mono<String> getUsageExamples() {
        StringBuilder usage = new StringBuilder();
        usage.append("=== Примеры использования API Gateway ===\n\n");
        usage.append("1. Прямые вызовы eureka-client (порт 8082):\n");
        usage.append("   GET http://localhost:8080/eureka-client/test\n");
        usage.append("   GET http://localhost:8080/eureka-client/name\n");
        usage.append("   GET http://localhost:8080/client/test\n");
        usage.append("   GET http://localhost:8080/api/client/test\n\n");
        usage.append("2. Прямые вызовы eureka-client-2 (порт 8083):\n");
        usage.append("   GET http://localhost:8080/eureka-client-2/test\n");
        usage.append("   GET http://localhost:8080/eureka-client-2/name\n");
        usage.append("   GET http://localhost:8080/client2/test\n");
        usage.append("   GET http://localhost:8080/api/client2/test\n\n");
        usage.append("3. Автоматические маршруты (через Discovery Locator):\n");
        usage.append("   GET http://localhost:8080/{service-id}/{endpoint}\n");
        usage.append("   Примеры:\n");
        usage.append("   - http://localhost:8080/eureka-client/test\n");
        usage.append("   - http://localhost:8080/eureka-client-2/name\n\n");
        usage.append("4. Информация о Gateway:\n");
        usage.append("   GET http://localhost:8080/gateway/info\n");
        usage.append("   GET http://localhost:8080/gateway/services\n");
        usage.append("   GET http://localhost:8080/gateway/usage\n");
        
        return Mono.just(usage.toString());
    }
}
