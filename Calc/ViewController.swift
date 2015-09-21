//
//  ViewController.swift
//  Calc
//
//  Created by Blaed Johnston on 9/15/15.
//  Copyright © 2015 Blaed Johnston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calcDisplay: UILabel!
   
    var appendToDisplay = false
    var operandStack = Array<Double>()
   
    @IBAction func digitInput(sender: UIButton) {
        let digit = sender.currentTitle!
        if appendToDisplay {
            calcDisplay.text = calcDisplay.text! + digit
        } else {
            calcDisplay.text = digit
            appendToDisplay = true
        }
    }
    
    
    @IBAction func enterPressed() {
        appendToDisplay = false
        operandStack.append(displayValue)
        print("stack: \(operandStack)")
    }

    func calculate(operation: (Double, Double) -> Double) {
        if appendToDisplay {
            enterPressed()
        }
        var firstOperand = 0.0
        if operandStack.count >= 1 {
            firstOperand = operandStack.popLast()!
        }
        if let secondOperand = operandStack.popLast() {
            displayValue = operation(firstOperand, secondOperand)
        } else {
            displayValue = operation(0.0, firstOperand)
        }
        enterPressed()
        print("stack: \(operandStack)")
    }

    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "+": calculate { $0 + $1 }
        case "−": calculate { $1 - $0 }
        case "÷": calculate { $1 / $0  }
        case "×": calculate { $0 * $1 }
        default: break
        }
    }
    
    
    func updateDisplay(message: String){
    }

    var displayValue: Double {
        get {
            let value = NSNumberFormatter().numberFromString(calcDisplay.text!)!.doubleValue
            return value
        }
        set {
            calcDisplay.text = "\(newValue)"
        }
    }
}



//-----------should move to a new file---------------------------------

class Operator {
    func perform(firstOperand: Double, secondOperand: Double) -> Double {
        return firstOperand
    }
}


class Adder: Operator {

    override func perform(firstOperand: Double, secondOperand: Double) -> Double {
        return firstOperand + secondOperand
    }
}

class Subtracter: Operator {
    override func perform(firstOperand: Double, secondOperand: Double) -> Double {
        return firstOperand - secondOperand
    }
}
