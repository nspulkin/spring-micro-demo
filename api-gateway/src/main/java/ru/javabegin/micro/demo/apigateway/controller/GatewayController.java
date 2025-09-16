package ru.javabegin.micro.demo.apigateway.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.util.List;

@RestController
public class GatewayController {

    private final DiscoveryClient discoveryClient;

    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${server.port}")
    private String port;

    public GatewayController(DiscoveryClient discoveryClient) {
        this.discoveryClient = discoveryClient;
    }

    @GetMapping("/gateway/status")
    public Mono<String> getGatewayStatus() {
        return Mono.just("API Gateway " + applicationName + " работает на порту " + port);
    }

    @GetMapping("/gateway/services")
    public Mono<String> getRegisteredServices() {
        return Mono.fromCallable(() -> {
            List<String> services = discoveryClient.getServices();
            return "Зарегистрированные сервисы: " + services.toString();
        });
    }

    @GetMapping("/gateway/health")
    public Mono<String> health() {
        return Mono.just("API Gateway работает корректно!");
    }
}
