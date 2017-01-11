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
    var numberIsClicked = false
    
    @IBOutlet weak var labelDisplay: UILabel!

    
    // 0 - 9 button pressed event handler
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        if (numberIsClicked) {
            // Append the number pressed to the right-most of the label
            labelDisplay.text = labelDisplay.text! + "\(sender.currentTitle!)"
        } else {
            // Display the number pressed
            labelDisplay.text = "\(sender.currentTitle!)"
            // Indicate that a number is already pressed
            numberIsClicked = true
        }
    }

    // AC button pressed event handler
    @IBAction func buttonACClicked(_ sender: UIButton) {
        // Set the display to 0
        labelDisplay.text = "0"
        // Reset the number clicked status
        numberIsClicked = false
    }
}

