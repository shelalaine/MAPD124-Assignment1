//
//  File Name:      ViewController.swift
//  Project Name:   MAPD124-Assignment1
//  Description:    This is the UI View Controller where various button event handlers are defined and 
//                  texts for the UILabel are updated.
//
//  Created by:     Shelalaine Chan
//  Student ID:     300924281
//  Change History: 2017-01-11, Created
//                  2017-01-13, Add a separate period(".") button event handler called buttonPeriodClicked function
//                  2017-01-22, Rename buttonBinaryOperatorsClicked to operationsClicked function 
//                              since this will now serve as button pressed handler for binary and unary 
//                              operations, and equals
//                  2017-01-23, Remove buttonSignClicked function
//
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
            if (labelDisplay.text! != "0") {
                labelDisplay.text = labelDisplay.text! + "\(sender.currentTitle!)"
                return
            }
        }
        
        // Show the number pressed
        labelDisplay.text = "\(sender.currentTitle!)"
                
        // Indicate that a number is already pressed
        numberIsClicked = true
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
    
    
    // Button pressed event handler to the following:
    //  Binary operator (×, ÷, +, −) 
    //  Unary operator (π, e, √, %, +/-, and Inv)
    //  Equals
    @IBAction func operationsClicked(_ sender: UIButton) {
        
        if numberIsClicked {
            operation.setOperand(operand: labelDisplay.text!)
        }

        if let operationSign = sender.currentTitle {
            print(operationSign)
            
//            // Do not proceed with the calculation if (+, -, x, or /) button is pressed and no new number is clicked
//            if (!numberIsClicked) {
//                if (operationSign == "+" || operationSign == "−" || operationSign == "×" || operationSign == "÷") {
//                    return
//                }
//            }
            // Perform binary operation
            operation.performOperation(symbol: operationSign)
                
            // Display the result
            labelDisplay.text = operation.result
        }
            
        // Indicate that neither number nor period is pressed
        numberIsClicked = false
        periodIsClicked = false
    }
    
    
    // AC button pressed event handler
    @IBAction private func buttonACClicked(_ sender: UIButton) {
        // Set the display to 0
        labelDisplay.text = "0"
        // Re-initialize any calculator operation
        operation.initOperation();
        
        // Reset the number and period clicked status
        numberIsClicked = false
        periodIsClicked = false
    }
    
}

