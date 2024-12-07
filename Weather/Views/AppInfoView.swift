//
//  AppInfo.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

import Foundation
import SwiftUI

struct AppInfoView: View {
    var body: some View {
        Form {
            Section(header: Text("App Info")) {
                Text("App: \(Bundle.main.displayName ?? "Weather")")
                Text("Version: \(Bundle.main.version ?? "1.0")")
                Text("Build: \(Bundle.main.build ?? "1")")
            }
            Text("© 2024 Weather")
        }
        .navigationTitle("App Info")
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}
