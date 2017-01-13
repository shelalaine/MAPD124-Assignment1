//
//  ViewController.swift
//  MAPD124-Assignment1
//
//  Created by Shelalaine Chan on 2017-01-11.
//  Copyright © 2017 ShelalaineChan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Indicate that no number / digit is pressed
    private var numberIsClicked = false
    private var operation = CalculatorOperation()
    
    @IBOutlet private weak var labelDisplay: UILabel!

    
    // 0 - 9 button pressed event handler
    @IBAction private func buttonClicked(_ sender: UIButton) {
        
        if (numberIsClicked) {
            // Append the number pressed to the right-most of the label
            labelDisplay.text = labelDisplay.text! + "\(sender.currentTitle!)"
        } else {
            // Display the number pressed if other than zero
            if (sender.currentTitle! != "0") {
                labelDisplay.text = "\(sender.currentTitle!)"
                
                // Indicate that a number is already pressed
                numberIsClicked = true
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
        
        // Indicate that no number is pressed
        numberIsClicked = false
    }
    
    
    // AC button pressed event handler
    @IBAction private func buttonACClicked(_ sender: UIButton) {
        // Set the display to 0
        labelDisplay.text = "0"
        
        // Reset the number clicked status
        numberIsClicked = false
    }
}

