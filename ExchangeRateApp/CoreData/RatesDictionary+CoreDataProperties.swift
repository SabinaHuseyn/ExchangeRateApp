//
//  RatesDictionary+CoreDataProperties.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 15.10.21.
//
//

import Foundation
import CoreData


extension RatesDictionary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RatesDictionary> {
        return NSFetchRequest<RatesDictionary>(entityName: "RatesDictionary")
    }

    @NSManaged public var rateList: NSDictionary?

}

extension RatesDictionary : Identifiable {

}
