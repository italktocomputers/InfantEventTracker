//
//  EventTimes.swift
//  InfantEventTracker
//
//  Created by Andrew Schools on 9/11/22.
//  Copyright © 2022 Andrew Schools. All rights reserved.
//

/*
import Foundation

enum EventType {
    case diaper_lastTime
    case bottle_lastTime
    case sleep_lastTime
    case diaperwet_lastTime
}

struct EventTimes {
    static var store: NSUbiquitousKeyValueStore?
    
    static func observeStore(notify callback: @escaping () -> Void) {
        NSUbiquitousKeyValueStore.default.synchronize()
        EventTimes.store = NSUbiquitousKeyValueStore.default
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(
                rawValue: "NSUbiquitousKeyValueStoreDidChangeExternallyNotification"
            ),
            object: nil,
            queue: nil,
            using: { (Notification) -> Void in
                callback()
            }
        )
    }
    
    static func sync() {
        EventTimes.store = NSUbiquitousKeyValueStore.default
    }
    
    static func triggerEvent(on date: Date, for eventType: EventType) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: date)
        EventTimes.store?.set(dateString, forKey: String(describing: eventType))
    }
    
    static func fetchTime(for key: EventType) -> String? {
        if let lastTime = EventTimes.store?.object(forKey: String(describing: key)) as? String {
            return lastTime
        }
        return nil
    }
}
*/
