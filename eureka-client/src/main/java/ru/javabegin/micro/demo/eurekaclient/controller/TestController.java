package ru.javabegin.micro.demo.eurekaclient.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${server.port}")
    private String port;

    @GetMapping("/test")
    public String test(){
        return "Приложение " + applicationName + " работает на порту " + port;
    }

    @GetMapping("/health")
    public String health(){
        return "Eureka Client работает корректно!";
    }
}
