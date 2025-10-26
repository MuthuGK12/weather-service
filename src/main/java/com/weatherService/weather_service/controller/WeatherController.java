package com.weatherService.weather_service.controller;

import com.weatherService.weather_service.model.WeatherRequest;
import com.weatherService.weather_service.service.WeatherService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class WeatherController {

    private final WeatherService weatherService;

    public WeatherController(WeatherService weatherService) {
        this.weatherService = weatherService;
    }

    // POST request with JSON body
    @PostMapping("/weather")
    public Map<String, Object> getWeather(@RequestBody WeatherRequest request) {
        return weatherService.getWeatherByCity(request.getCity());
    }
}
