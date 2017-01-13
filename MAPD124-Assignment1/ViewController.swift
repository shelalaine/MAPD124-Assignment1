//
//  ViewController.swift
//  MAPD124-Assignment1
//
//  Created by Shelalaine Chan on 2017-01-11.
//  Copyright © 2017 ShelalaineChan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var operation = CalculatorOperation()

    // Number and period clicked status
    private var numberIsClicked = false
    private var periodIsClicked = false
    
    @IBOutlet private weak var labelDisplay: UILabel!

    
    // 0 - 9 button pressed event handler
    @IBAction private func buttonClicked(_ sender: UIButton) {
        
        if (numberIsClicked) {
            // Append the number pressed to the right-most of the label
            labelDisplay.text = labelDisplay.text! + "\(sender.currentTitle!)"
        } else {
            // Display the number pressed if other than zero
            if (sender.currentTitle! != "0") {
                
                // Show the number pressed
                labelDisplay.text = "\(sender.currentTitle!)"
                
                // Indicate that a number is already pressed
                numberIsClicked = true
            }
        }
    }
    
    // Period (".") button pressed event handler
    @IBAction func buttonPeriodClicked(_ sender: UIButton) {
        
        if !numberIsClicked {
            labelDisplay.text = "0\(sender.currentTitle!)"
            
            // Indicate that number and period has been clicked
            periodIsClicked = true
            numberIsClicked = true
        } else {
            if !periodIsClicked {
                // Append the "." pressed to the right-most of the label
                labelDisplay.text = labelDisplay.text! + "\(sender.currentTitle!)"
                
                // Indicate that period has been clicked
                periodIsClicked = true
            }
        }
    }
    
    
    // Binary operator (×, ÷, +, −) button pressed event handler
    @IBAction func buttonBinaryOperatorsClicked(_ sender: UIButton) {
        
        if numberIsClicked {
            operation.setOperand(operand: Double(labelDisplay.text!)!)
        }
        
        if let binaryOperator = sender.currentTitle {
            // Perform binary operation
            operation.performOperation(symbol: binaryOperator)
            
            // Display the result
            labelDisplay.text = String(operation.result)
        }
        
        // Indicate that neither number nor period is pressed
        numberIsClicked = false
        periodIsClicked = false
    }
    
    
    // AC button pressed event handler
    @IBAction private func buttonACClicked(_ sender: UIButton) {
        // Set the display to 0
        labelDisplay.text = "0"
        
        // Reset the number and period clicked status
        numberIsClicked = false
        periodIsClicked = false
    }
}

