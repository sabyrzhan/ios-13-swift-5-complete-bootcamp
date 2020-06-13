//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFinishRequest(withBitcoin: BitcoinModel)
    func didFailWithError(error: Error?)
}

struct CoinManager {
    
    let baseURL = "https://blockchain.info/ticker"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","INR","RUB","SEK","SGD","USD"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        performRequest(forKey: currency)
    }
    
    func performRequest(forKey: String) {
        if let url = URL(string: baseURL) {
            let session  = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let safeData = data {
                    if let bitcoinModel = self.parse(data: safeData, forKey: forKey) {
                        self.delegate?.didFinishRequest(withBitcoin: bitcoinModel)
                    } else {
                        self.delegate?.didFailWithError(error: error)
                    }
                } else {
                    self.delegate?.didFailWithError(error: error)
                }
            }
            task.resume()
        }
    }
    
    func parse(data: Data, forKey: String) -> BitcoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BitcoinResponse.self, from: data)
            let itemResponse = decodedData.getByCurrency(currency: forKey)
            let bitcoinModel = BitcoinModel(currency: forKey, price: itemResponse?.last ?? 0)
            return bitcoinModel
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
