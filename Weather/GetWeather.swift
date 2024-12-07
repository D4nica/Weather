//
//  GetWeather.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

import Foundation

struct WeatherAPI {
    static let baseURL = "https://api.weatherapi.com/v1"
    static let apiKey = "a1d9cb3d53f241edb7a83949240512"
}

class GetWeather {
    func fetchCurrentWeather(for city: String) async throws -> Weather {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(WeatherAPI.baseURL)/current.json?key=\(WeatherAPI.apiKey)&q=\(encodedCity)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(Weather.self, from: data)
    }
    
    func fetchForecastWeather(for city: String) async throws -> ForecastResponse {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(WeatherAPI.baseURL)/forecast.json?key=\(WeatherAPI.apiKey)&q=\(encodedCity)&days=7") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(ForecastResponse.self, from: data)
    }
}
