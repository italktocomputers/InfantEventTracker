//
//  ViewModel.swift
//  InfantEventTracker
//
//  Created by Andrew Schools on 9/11/22.
//  Copyright © 2022 Andrew Schools. All rights reserved.
//

import Foundation
import CloudKit

enum EventType {
    case diaper_lastTime
    case bottle_lastTime
    case sleep_lastTime
    case diaperwet_lastTime
}

struct ViewModel {
    var container: CKContainer
    var database: CKDatabase
    var localStore: UserDefaults
    var data: [String:String]?
    
    init() {
        container = CKContainer.init(identifier: "iCloud.Schools.InfantEventTracker")
        database = container.privateCloudDatabase
        localStore = UserDefaults.init()
        // localStore.removeObject(forKey: "recordName")
        // exit(0)
                
        let newSubscription = CKQuerySubscription(
            recordType: "InfantEvent",
            predicate: NSPredicate(value: true),
            options: [.firesOnRecordCreation, .firesOnRecordUpdate]
        )
        
        let notification = CKSubscription.NotificationInfo()
        notification.shouldSendContentAvailable = true
        newSubscription.notificationInfo = notification
        
        database.save(newSubscription) { (subscription, error) in
            if let error = error {
                print(error)
                return
            }

            if let _ = subscription {
                print("Subscription created")
            }
        }
    }
    
    func saveAction(on value: Date, for key: EventType) {
        let record = CKRecord(recordType: "InfantEvent")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: value)
        
        // we need to save all data here 
        record.setValue(dateString, forKey: String(describing: key))
        insertRecord(record: record)
    }
    
    func insertRecord(record: CKRecord) {
        database.save(record) { record, error in
            if let error = error {
                print(error)
            }
            else {
                print("saving new record ID...")
                localStore.set(record?.recordID.recordName, forKey: "recordName")
            }
        }
    }
    
    func getLastTime(for key: String, callback: @escaping (String) -> Void) {
        if let times = data {
            callback(times[key] ?? "00:00:00")
        }
        else {
            print("Fetching record")
            getData { (record: CKRecord?) -> Void in
                if let record = record {
                    print(record)
                    callback(record.value(forKey: key) as? String ?? "00:00:00")
                }
            }
        }
    }
    
    private func getData(_ callback: @escaping (CKRecord?) -> Void) {
        if let recordName = localStore.string(forKey: "recordName") {
            let recordId = CKRecord.ID(recordName: recordName)
            database.fetch(withRecordID: recordId, completionHandler: { record, error in
                if let e = error {
                    print(e)
                }
                else {
                    callback(record)
                }
            })
        }
    }
}
