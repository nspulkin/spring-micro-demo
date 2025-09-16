package ru.javabegin.micro.demo.apigateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                // Маршруты для eureka-client
                .route("eureka-client-direct", r -> r
                        .path("/client/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://eureka-client"))
                
                .route("eureka-client-api", r -> r
                        .path("/api/client/**")
                        .filters(f -> f.stripPrefix(2))
                        .uri("lb://eureka-client"))
                
                .route("eureka-client-by-name", r -> r
                        .path("/eureka-client/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://eureka-client"))
                
                // Маршруты для eureka-client-2
                .route("eureka-client-2-direct", r -> r
                        .path("/client2/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://eureka-client-2"))
                
                .route("eureka-client-2-api", r -> r
                        .path("/api/client2/**")
                        .filters(f -> f.stripPrefix(2))
                        .uri("lb://eureka-client-2"))
                
                .route("eureka-client-2-by-name", r -> r
                        .path("/eureka-client-2/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://eureka-client-2"))
                
                .build();
    }
}
