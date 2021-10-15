//
//  Timestamp+CoreDataProperties.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 15.10.21.
//
//

import Foundation
import CoreData


extension Timestamp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timestamp> {
        return NSFetchRequest<Timestamp>(entityName: "Timestamp")
    }

    @NSManaged public var time: Int32

}

extension Timestamp : Identifiable {

}
