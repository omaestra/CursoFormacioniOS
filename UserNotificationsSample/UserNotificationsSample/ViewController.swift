//
//  ViewController.swift
//  UserNotificationsSample
//
//  Created by omaestra on 09/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scheduleNotification()
//        self.scheduleNotificationForCoffee()
    }
    
    func scheduleNotificationForCoffee() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Coffee time"
        content.sound = UNNotificationSound.default
        
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone(secondsFromGMT: 7200), hour: 10, minute: 30, second: 0)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "coffeeNotification", content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "New notification"
        content.body = "Nueva notificacion desde curso iOS Cordoba"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "UserActions"
        content.badge = 1
        
        let imageURL = Bundle.main.url(forResource: "medal", withExtension: "png")
        let attachment = try! UNNotificationAttachment(identifier: "medal", url: imageURL!, options: nil)
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "cordobaNotification", content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
        
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION", title: "Snooze", options: [.foreground])
        let deleteAction = UNNotificationAction(identifier: "DELETE_ACTION", title: "Delete", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: "UserActions", actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [.customDismissAction])
        
        center.setNotificationCategories([category])
        
        
    }
}

