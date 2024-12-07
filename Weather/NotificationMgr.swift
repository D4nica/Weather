//
//  NotificationMgr.swift
//  Weather
//
//  Created by Danica Kim on 12/5/24.
//

import Foundation
import UserNotifications

class NotificationMgr: NSObject, ObservableObject, UNUserNotificationCenterDelegate {

    override init() {
        super.init()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        }
    }

    func triggerNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Welcome Back!"
        content.body = "Check out the latest weather updates."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "appOpened", content: content, trigger: trigger)

        center.add(request) { error in
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
