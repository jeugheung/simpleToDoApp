//
//  Model.swift
//  toDo Project
//
//  Created by Andrey Kim on 11.06.2021.
//

import Foundation
import UserNotifications
import UIKit

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "toDoDataKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "toDoDataKey")
            as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name": nameItem, "isCompleted": false])
    setBadge()
}

func removeItem(at index: Int) {
    toDoItems.remove(at: index)
    setBadge()
}

func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return (toDoItems[item]["isCompleted"] as? Bool)!
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = toDoItems[fromIndex]
    toDoItems.remove(at: fromIndex)
    toDoItems.insert(from, at: toIndex)
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) {
        (isEnabled, error) in
        if isEnabled {
            print("Success")
        } else {
            print("Not success")
        }
    }
}

func setBadge() {
    var totalBadgeNumber = 0
    for item in toDoItems {
        if item["isCompleted"] as? Bool == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}
