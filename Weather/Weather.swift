//
//  Weather.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

struct Weather: Codable {
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime_epoch: Int
        let localtime: String
    }
    
    struct Condition: Codable {
        let text: String
        let icon: String
        let code: Int
    }
    
    struct Current: Codable {
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        let condition: Condition
        let wind_mph: Double
        let wind_kph: Double
        let humidity: Int
        
    }
    
    let location: Location
    let current: Current
}

struct ForecastResponse: Codable {
    struct ForecastDay: Codable {
        let date: String
        let day: DayWeather
    }

    struct DayWeather: Codable {
        
        let avgtemp_c: Double
        let avgtemp_f: Double
        let maxtemp_c: Double
        let maxtemp_f: Double
        let mintemp_c: Double
        let mintemp_f: Double
    }

    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastday: [ForecastResponse.ForecastDay]
}
