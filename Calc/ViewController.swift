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
    var operatorStack = Array<Operator>()
   
    @IBAction func digitInput(sender: UIButton) {
        let digit = sender.currentTitle!
        updateDisplay(digit)
        appendToDisplay = true
    }
    
    
    @IBAction func enterPressed() {
        appendToDisplay = false
        operandStack.append(displayValue)
        print(operandStack)
    }

    func calculate() -> Double? {
        appendToDisplay = false
        if let lastOperator = operatorStack.popLast() {
            let val = lastOperator.perform(operandStack.popLast()!, secondOperand: operandStack.popLast()!)
            return val
        }
        return 0.0
    }

    @IBAction func addPressed() {
        operatorStack.append(Adder())
        let result = calculate()!
        updateDisplay("\(result)")
        operandStack.append(result)
    }

    func updateDisplay(message: String){
        if appendToDisplay {
            calcDisplay.text = calcDisplay.text! + message
        } else {
            calcDisplay.text = message
        }
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
