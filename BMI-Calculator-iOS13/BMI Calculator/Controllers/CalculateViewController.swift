//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onValueChanged(_ sender: UISlider) {
        if sender == slider1 {
            heightLabel.text = "\(String(format: "%.1f", sender.value))m"
        } else {
            weightLabel.text = "\(Int(sender.value))kg"
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        calculatorBrain.calculate(height: slider1.value, weight: slider2.value)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let dest = segue.destination as! ResultViewController
            dest.bmiValue = calculatorBrain.getBMIValue()
            dest.advice = calculatorBrain.getAdvice()
            dest.color = calculatorBrain.getColor()
        }
    }
}

