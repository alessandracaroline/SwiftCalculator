//
//  ViewController.swift
//  Calculator
//
//  Created by Alessandra Caroline Faisst on 29/09/15.
//  Copyright © 2015 Alessandra Caroline Faisst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if (digit == "." && display.text!.rangeOfString(".") != nil) {
                return
            } else {
                display.text = display.text! + digit
            }
        } else {
            display.text = digit == "." ? "0" + digit : digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
//            here later set display Value to optional, then I could set it to nil here and maybe display error msg
        }
    }
    
    @IBAction func clear() {
        brain.clear()
        displayValue = 0
        
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            history.text = brain.showStack()
        }
    }
}



// OLD CODE for reference 
//      in function operate
//            switch operation {
//            case "×": performOperation {$0 * $1}
//            case "÷": performOperation {$1 / $0}
//            case "+": performOperation {$0 + $1}
//            case "−": performOperation {$1 - $0}
//            case "√": performOperationOneArgument { sqrt($0) }
//            case "sin": performOperationOneArgument { sin($0) }
//            case "cos": performOperationOneArgument { cos($0) }
//            default: break
//            }

//    func performOperation(operation: (Double, Double) -> Double) {
//        if operandStack.count >= 2 {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//
//    func performOperationOneArgument(operation: Double -> Double) {
//        if operandStack.count >= 1 {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }

//    var operandStack = Array<Double>()

// in function enter
//        operandStack.append(displayValue)


