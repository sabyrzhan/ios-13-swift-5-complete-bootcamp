//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let softTime = 5
    let meduimTime = 7
    let hardTime = 12
    
    let times = ["Soft" : 5, "Medium" : 7, "Hard": 12]
    var timer = Timer()
    var pressedButton = ""
    var time = 0
    
    let originalTitle = "How do you like your eggs?"
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        if time == 0 || pressedButton != hardness {
            print("Pressed: " + hardness)
            progressView.progress = 0.0
            label.text = hardness
            time = times[hardness]!
            pressedButton = hardness
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        } else {
            print("Skipping this button")
        }
    }
    
    @objc func updateTimer() {
        print("Counting: " + pressedButton + " timer: " + String(time))
        progressView.progress = getPerc()
        if time <= 0 {
            timer.invalidate()
            label.text = "DONE!"
            do {
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
            return;
        }
        
        
        time -= 1
    }
    
    func getPerc() -> Float {
        let originalTime = times[pressedButton]!
        let perc = 1 - Float(time) / Float(originalTime)
        print("Perc \(perc)")
        return perc
    }
    
}
