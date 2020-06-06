//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var percent = 10
    var calculateResult: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        billTextField.resignFirstResponder()
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        if sender == zeroPctButton {
            percent = 0
        } else if sender == tenPctButton {
            percent = 10
        } else if sender == twentyPctButton {
            percent = 20
        }
        
        sender.isSelected = true
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = "\(Int(sender.value))"
        billTextField.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill:Float? = Float(billTextField.text!)
        if let billValue = bill {
            let perEach = billValue / Float(splitNumberLabel.text!)!
            let tipValue = perEach * Float(percent) / 100.0
            calculateResult = perEach + tipValue
            performSegue(withIdentifier: "showResultSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultSegue" {
            let dest = segue.destination as! ResultsViewController
            dest.result = calculateResult
            dest.people = Int(splitNumberLabel.text!)!
            dest.percent = percent
        }
    }
}

