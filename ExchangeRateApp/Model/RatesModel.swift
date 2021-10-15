//
//  RatesModel.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 14.10.21.
//

import Foundation


//struct Rate: Codable {
//    var GBP: Float
//    var JPY: Float
//    var AED: Float
//    var PLN: Float
//    var AZN: Float
//    var USD: Float
//    
//    enum CodingKeys: String, CodingKey {
//        case GBP, JPY, AED, PLN, AZN, USD
//    }
//}
    
struct RatesModel: Codable {
    var success: Bool
    var timestamp: Int?
    var historical: Bool?
    var base: String?
    var date: String?
    var rates: [String: Float]
   
    enum CodingKeys: String, CodingKey {
        case success, timestamp, historical, base, date, rates
    }
}
