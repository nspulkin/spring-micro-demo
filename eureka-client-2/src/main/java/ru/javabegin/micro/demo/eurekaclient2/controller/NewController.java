package ru.javabegin.micro.demo.eurekaclient2.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NewController {

    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${server.port}")
    private String port;

    // Эндпоинты в корне для удобного тестирования
    @GetMapping("/test")
    public String test(){
        return "Тест из " + applicationName + " на порту " + port;
    }

    @GetMapping("/name")
    public String name(){
        return "Привет из " + applicationName + "!";
    }

    // Эндпоинты с префиксом /new
    @GetMapping("/new/name")
    public String nameWithPrefix(){
        return "Hello, World!";
    }

    @GetMapping("/new/health")
    public String health(){
        return "Eureka Client работает корректно!";
    }
}
