//
//  ViewController+CoreData.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 15.10.21.
//

import Foundation
import UIKit
import CoreData

extension ViewController {
    
    func saveRatesToCoreData(_ rate: [String: Float]) {
        let context = persistenceManager.context
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RatesDictionary")
        
        do {
            let object = try context.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(rate, forKey: "rateList")
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            } else if object.count == 0 {
                
                let newRate = RatesDictionary(context: persistenceManager.context)
                newRate.rateList = rate as NSDictionary
                
                persistenceManager.save()
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func saveTimeToCoreData(_ time: Int) {
        let context = persistenceManager.context
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Timestamp")
        
        do {
            let object = try context.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(Int32(time), forKey: "time")
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            } else if object.count == 0 {
                
                let newTime = Timestamp(context: persistenceManager.context)
                newTime.time = Int32(time)
                
                persistenceManager.save()
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func getSavedRates() {
        let savedData = persistenceManager.fetch(RatesDictionary.self)
        for save in savedData {
            DispatchQueue.main.async {
                self.rates.removeAll()
                self.ratesDictionary = [:]
                self.ratesDictionary = save.rateList!
                print(self.ratesDictionary)
                self.mainTableView.reloadData()
                
            }
        }
    }
    
    func getSavedTime() {
        let savedData = persistenceManager.fetch(Timestamp.self)
        for save in savedData {
            self.timeStamp = save.time
            print(self.timeStamp!)
        }
    }
    
}
