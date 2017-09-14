//
//  ViewController.swift
//  Calculator
//
//  Created by Jesús Muñoz on 14/09/2017.
//  Copyright © 2017 Jesús Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func touchDigit(_ sender: UIButton) {
        // underbar: not external touchDigig(someButton). Not used for 2-> n argument, only (ocasionally) for the first
        let digit = sender.currentTitle!
        if (userIsInTheMiddleOfTyping) {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    // Double: type√
    // two names: 1st: external (used by the caller. Mandatory for the caller.)
    // 2nd: internal (inside of this method)
    func drawHorizontalLine(from startX: Double, to endX: Double, using color: UIColor) -> String {
        return ""
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
}

