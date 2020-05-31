//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Sabyrzhan Tynybayev on 6/1/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    mutating func calculate(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2.0)
        switch bmiValue {
        case ..<18.5:
            bmi = BMI(value: bmiValue, advice: "Eat more pies.", color: .blue)
        case 18.5...24.9:
            bmi = BMI(value: bmiValue, advice: "Fit as fiddle.", color: .green)
        default:
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: .red)
        }
        
    }
    
    func getBMIValue() -> String {
        return String(format: "%.2f", bmi?.value ?? 0.0)
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? ""
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.gray
    }
}
