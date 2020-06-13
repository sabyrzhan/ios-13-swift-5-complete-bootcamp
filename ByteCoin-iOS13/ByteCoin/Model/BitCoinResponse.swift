//
//  BitCoinResponse.swift
//  ByteCoin
//
//  Created by Sabyrzhan Tynybayev on 6/13/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation
struct BitcoinResponse: Codable {
    let AUD: BitcointItemResponse
    let BRL: BitcointItemResponse
    let CAD: BitcointItemResponse
    let CNY: BitcointItemResponse
    let EUR: BitcointItemResponse
    let GBP: BitcointItemResponse
    let HKD: BitcointItemResponse
    let INR: BitcointItemResponse
    let JPY: BitcointItemResponse
    let RUB: BitcointItemResponse
    let SEK: BitcointItemResponse
    let SGD: BitcointItemResponse
    let USD: BitcointItemResponse
    
    func getByCurrency(currency: String) -> BitcointItemResponse? {
        switch currency {
        case "AUD":
            return AUD
        case "BRL":
            return BRL
        case "CAD":
            return CAD
        case "CNY":
            return CNY
        case "EUR":
            return EUR
        case "GBP":
            return GBP
        case "HKD":
            return HKD
        case "INR":
            return INR
        case "JPY":
            return JPY
        case "RUB":
            return RUB
        case "SEK":
            return SEK
        case "SGD":
            return SGD
        case "USD":
            return USD
        default:
            return nil
        }
    }

}

struct BitcointItemResponse: Codable {
    let last: Float
}
