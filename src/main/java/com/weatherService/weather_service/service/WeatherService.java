package com.weatherService.weather_service.service;

import com.weatherService.weather_service.model.WeatherResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class WeatherService {

    @Value("${weather.api.key}")
    private String apiKey;

    private static final String BASE_URL = "https://api.weatherapi.com/v1/current.json";

    public Map<String, Object> getWeatherByCity(String city) {
        Map<String, Object> result = new HashMap<>();
        String url = BASE_URL + "?key=" + apiKey + "&q=" + city + "&aqi=no";
        RestTemplate restTemplate = new RestTemplate();

        try {
            WeatherResponse response = restTemplate.getForObject(url, WeatherResponse.class);

            if (response != null && response.getLocation() != null) {
                result.put("success", true);
                result.put("message", "Weather data fetched successfully");
                result.put("city", response.getLocation().getName());
                result.put("data", response);
            } else {
                result.put("success", false);
                result.put("message", "No data found for city: " + city);
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Failed to fetch weather for '" + city + "': " + e.getMessage());
        }

        return result;
    }
}
