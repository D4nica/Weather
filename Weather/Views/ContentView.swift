//
//  ContentView.swift
//  Weather
//
//  Created by Danica Kim on 12/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowing = false
    @AppStorage("colorScheme") var colorScheme = 0
    @StateObject private var notificationMgr = NotificationMgr()
    var body: some View {
        TabView {
            CurrentWeatherView()
                .tabItem {
                    Label("Current", systemImage: "sun.max")
                }
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.rain")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            AppInfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
        }
        .onAppear {
            notificationMgr.triggerNotification()
            print("Notification triggered.")
        }
        Button("Rate Us!"){
            isShowing.toggle()
        }
        .confirmationDialog("How did we do?", isPresented: $isShowing, titleVisibility: .visible){
            Button("Great"){
            }
            Button("Okay"){
            }
            Button("Meh"){
            }
            Button("Not Good"){
            }
        }
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }
}
#Preview {
    ContentView()
}


