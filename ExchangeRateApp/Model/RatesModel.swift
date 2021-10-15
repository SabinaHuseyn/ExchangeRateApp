//
//  RatesModel.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 14.10.21.
//

import Foundation
    
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
