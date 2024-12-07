//
//  SettingsView.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @AppStorage("temperatureUnit") private var temperatureUnit = "Celsius"
    @AppStorage("windUnit") private var windUnit = "Kilometer"
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("colorScheme") var colorScheme = 0
 



    var body: some View {
        Form {
            Picker("Temperature Unit", selection: $temperatureUnit) {
                Text("Celsius").tag("Celsius")
                Text("Fahrenheit").tag("Fahrenheit")
            }
            Picker("Wind Unit", selection: $temperatureUnit) {
                Text("Kilometers").tag("Kilometers")
                Text("Miles").tag("Miles")
            }
            Toggle("Enable Notifications", isOn: $notificationsEnabled)
            Section("Appearance") {
                Picker(selection: $colorScheme, label: Text("Appearance")) {
                    Text("Light").tag(1)
                    Text("Dark").tag(2)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
