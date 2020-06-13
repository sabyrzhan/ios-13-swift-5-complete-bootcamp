//
//  BitcoinModel.swift
//  ByteCoin
//
//  Created by Sabyrzhan Tynybayev on 6/13/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct BitcoinModel {
    let currency: String
    let price: Float
    
    var priceText: String {
        return String(format: "%.2f", price)
    }
}
