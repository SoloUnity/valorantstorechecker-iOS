//
//  NotificationService.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-10.
//

// From https://www.youtube.com/watch?v=eI7jYIY5Ie4

import Foundation
import UserNotifications
import SwiftUI

class NotificationService {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            
            if success {
                print("Access granted!")
            }
            else if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func sendNotification(date: Date, title: String, body: String) {
        
        var trigger : UNNotificationTrigger?
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        print("notification sent")
    }
    
    func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("notification canceled")
    }
}

