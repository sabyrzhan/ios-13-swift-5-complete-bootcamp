//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Sabyrzhan Tynybayev on 6/6/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var result: Float = 0
    var people = 0
    var percent = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(format: "%.2f", result)
        settingsLabel.text = "Split between \(people) people, with \(percent)% tip."
    }

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
