//
//  CalculatorOperation.swift
//  MAPD124-Assignment1
//
//  Created by Shelalaine Chan on 2017-01-13.
//  Copyright © 2017 ShelalaineChan. All rights reserved.
//

import Foundation

class CalculatorOperation {
    private struct PendingOperation {
        var firstOperand: Double
        var binaryFunction: (Double, Double) -> Double
    }
    
    private var pendingOperation: PendingOperation?
    private var resultOperation = 0.0

    // Add operation taking in two operands and returning the result as double
    func operationAdd(op1: Double, op2: Double) -> Double {
        return op1 + op2
    }
    
    // Subtract operation taking in two operands and returning the result as double
    func operationSubtract(op1: Double, op2: Double) -> Double {
        return op1 - op2
    }
    
    // Multiply operation taking in two operands and returning the result as double
    func operationMultiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    // Divide operation taking in two operands and returning the result as double
    func operationDivide(op1: Double, op2: Double) -> Double {
        return op1 / op2
    }
    
    // Set the operand of the math operation
    func setOperand(operand: Double) {
        resultOperation = operand
    }
    
    // Perform the desired operation such as add, subtract, multiply, divide, and getting the result
    func performOperation(symbol: String) {
        switch symbol {
        case "+":
            pendingOperation = PendingOperation(firstOperand: resultOperation, binaryFunction: operationAdd)
        case "−":
            pendingOperation = PendingOperation(firstOperand: resultOperation, binaryFunction: operationSubtract)
        case "×":
            pendingOperation = PendingOperation(firstOperand: resultOperation, binaryFunction: operationMultiply)
        case "÷":
            pendingOperation = PendingOperation(firstOperand: resultOperation, binaryFunction: operationDivide)
        case "=":
            if (pendingOperation != nil) {
                resultOperation = pendingOperation!.binaryFunction(pendingOperation!.firstOperand, resultOperation)
            }
        default:
            break
        }
    }
    
    // Return the result of the operation
    var result: Double {
        get {
            return resultOperation
        }
    }
}
