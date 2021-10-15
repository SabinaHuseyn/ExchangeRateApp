//
//  RatesViewModel.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 14.10.21.
//

import Foundation
import UIKit

struct RatesViewModel {

    let rate: [String: Float]

// Dependency Injection (DI)
    init(ratesModel: [String: Float]) {
        self.rate = ratesModel
}
}
