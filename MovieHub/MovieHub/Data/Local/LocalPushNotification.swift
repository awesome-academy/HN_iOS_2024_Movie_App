//
//  LocalPushNotification.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 25/04/2024.
//

import Foundation
import UserNotifications

final class LocalPushNotification {
    static let shared = LocalPushNotification()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func checkForPermissionNotification() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestNotificationPermission()
            case .authorized:
                self.scheduleDailyNotification()
            default:
                return
            }
        }
    }
    
    private func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, _ in
            if didAllow {
                self.scheduleDailyNotification()
            }
        }
    }
    
    private func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "noti.title".localized()
        content.body = "noti.body".localized()
        content.sound = .default
        
        // Fixed time is 19:30:30 PM
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 30
        dateComponents.second = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Daily notification scheduled successfully.")
            }
        }
    }
}
