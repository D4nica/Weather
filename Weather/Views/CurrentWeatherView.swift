//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    @State private var forecast: ForecastResponse?
    @State private var weather: Weather?
    @State private var city: String = "Rochester"
    @State private var showDetails = false
    @State private var isLoading = false
    @State private var rotateIcon = false
    @AppStorage("temperatureUnit") private var temperatureUnit = "Celsius"
    @AppStorage("windUnit") private var windUnit = "Kilometers"
    @AppStorage("favoriteCity") private var favoriteCity: String?

    
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(NSLocalizedString("Fetch Weather", comment: "Fetch Weather")) {
                isLoading = true
                withAnimation(.easeInOut(duration: 0.5)) {
                                    showDetails = false
                                }                
                Task {
                    rotateIcon = true
                    do {
                        let service = GetWeather()
                        weather = try await service.fetchCurrentWeather(for: city)
                        isLoading = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showDetails = true
                            }
                            rotateIcon = false
                        }
                    } catch {
                        isLoading = false
                        rotateIcon = false
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button(NSLocalizedString("Save as Favorites", comment: "Save as Favorites"))
 {
                favoriteCity = city
            }
            .buttonStyle(.borderedProminent)
            
            if let weather = weather {
                VStack(spacing: 10) {
                    ZStack {
                        Image(systemName: "cloud.sun.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.orange)
                            .rotationEffect(Angle.degrees(rotateIcon ? 360 : 0))
                            .animation(
                                rotateIcon
                                ? .linear(duration: 3).repeatForever(autoreverses: false)
                                : .default,
                                value: rotateIcon
                            )
                    }
                    Text(weather.location.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                Text(formattedTemperature(weather.current.temp_c, weather.current.temp_f))
                    .font(.system(size: 50))
                Text(weather.current.condition.text)
                    .italic()
                Text("Wind: \(formattedSpeed(weather.current.wind_kph, weather.current.wind_mph))")
                Text("Humidity: \(weather.current.humidity)%")
            }
                .padding()
                .opacity(showDetails ? 1 : 0)
                .offset(y: showDetails ? 0 : 20)
        } else if isLoading {
            ProgressView(NSLocalizedString("Loading...", comment: "Loading..."))

        }
    }
        .padding()
        .onAppear {
            if let favoriteCity = favoriteCity {
                city = favoriteCity
                fetchForecast()
            }
        }
    
}
    private func formattedTemperature(_ tempC: Double, _ tempF: Double) -> String {
        switch temperatureUnit {
        case "Fahrenheit":
            return String(format: "%.1f°F", tempF)
        default:
            return String(format: "%.1f°C", tempC)
        }
    }
    
    private func formattedSpeed(_ wind_kph: Double, _ wind_mph: Double) -> String {
        switch temperatureUnit {
        case "Miles":
            return String(format: "%.1f m/h", wind_mph)
        default:
            return String(format: "%.1f km/h", wind_kph)
        }
    }
    
    private func fetchForecast() {
            isLoading = true
            Task {
                do {
                    let service = GetWeather()
                    forecast = try await service.fetchForecastWeather(for: city)
                    isLoading = false
                } catch {
                    print("Error fetching forecast: \(error)")
                    isLoading = false
                }
            }
        }
    
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}

