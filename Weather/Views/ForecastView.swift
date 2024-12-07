//
//  ForecastView.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

import SwiftUI

struct ForecastView: View {
    @State private var forecast: ForecastResponse?
    @State private var city: String = "Rochester"
    @State private var showDetails = false
    @State private var isLoading = false
    @AppStorage("temperatureUnit") private var temperatureUnit = "Celsius"
    @AppStorage("favoriteCity") private var favoriteCity: String?


    var body: some View {
        VStack {
            TextField("Enter city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Fetch Forecast") {
                fetchForecast()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Save as Favorite") {
                                favoriteCity = city
                            }
            .buttonStyle(.borderedProminent)

            if let forecast = forecast {
                List(forecast.forecast.forecastday, id: \.date) { day in
                    VStack(alignment: .leading) {
                        Text(day.date)
                            .font(.headline)
                        Text("Max: \(formattedTemperature(day.day.maxtemp_c, day.day.maxtemp_f))")
                        Text("Min: \(formattedTemperature(day.day.mintemp_c, day.day.mintemp_f))")
                        Text("Avg Temp: \(formattedTemperature(day.day.avgtemp_c, day.day.avgtemp_f))")
                       
                            .italic()
                    }
                    .padding()
                    .opacity(showDetails ? 1 : 0)
                    .offset(y: showDetails ? 0 : 20)
                    .animation(.easeInOut(duration: 1.0), value: showDetails)
                }
            } else if isLoading {
                ProgressView("Loading...")
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

    private func fetchForecast() {
        isLoading = true
        showDetails = false
        Task {
            do {
                let service = GetWeather()
                forecast = try await service.fetchForecastWeather(for: city)
                isLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showDetails = true
                    }
                }
            } catch {
                print("Error fetching forecast: \(error)")
                isLoading = false
                
            }
        }
    }
        
    }

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
