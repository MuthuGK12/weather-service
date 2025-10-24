package com.weatherService.weather_service.model;

import lombok.Data;

@Data
public class WeatherResponse {
    private Location location;
    private Current current;

    @Data
    public static class Location {
        private String name;
        private String region;
        private String country;
    }

    @Data
    public static class Current {
        private double temp_c;
        private int humidity;
        private double wind_kph;
    }
}