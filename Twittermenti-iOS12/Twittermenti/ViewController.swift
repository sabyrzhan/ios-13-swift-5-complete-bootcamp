//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Swifter
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = try! MyTextClassifier(configuration: MLModelConfiguration())
    
    let swifter = Swifter(consumerKey: "CONSUMER_KEY", consumerSecret: "CONSUMER_SECRET")

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    @IBAction func predictPressed(_ sender: Any) {
        let text = textField.text!
        if !text.isEmpty {
            swifter.searchTweet(using: text, lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
                var tweets = [MyTextClassifierInput]()
                
                for i in 0..<100 {
                    if let tweet = results[i]["full_text"].string {
                        tweets.append(MyTextClassifierInput(text: tweet))
                    }
                }
                let predictions = try! self.sentimentClassifier.predictions(inputs: tweets, options: MLPredictionOptions.init())
                var score = 0
                for predication in predictions {
                    switch predication.label {
                    case "Pos":
                        score += 1
                    case "Neg":
                        score -= 1
                    default:
                        score += 0
                    }
                }
                
                if score > 0 {
                    self.sentimentLabel.text = "🙂"
                } else if score < 0 {
                    self.sentimentLabel.text = "🙁"
                } else {
                    self.sentimentLabel.text = "😐"
                }
            } failure: { (error) in
                print("Error occured while requesting Twitter: \(error)")
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter text", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
}

