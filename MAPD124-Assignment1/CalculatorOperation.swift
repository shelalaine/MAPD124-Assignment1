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
        // Binary function which takes two parameters as a Double type and returns the result in Double
        //  First parameter: first / previous operand
        //  Second parameter: new operand
        var binaryFunction: (Double, Double) -> Double
    }
    
    private var pendingOperation: PendingOperation?
    private var resultOperation = 0.0
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        
        // Add operation taking in two operands and returning the result as double
        "+": Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 + op2 }),
        
        // Subtract operation taking in two operands and returning the result as double
        "−": Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 - op2 }),
        
        // Multiply operation taking in two operands and returning the result as double
        "×": Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 * op2 }),
        
        // Divide operation taking in two operands and returning the result as double
        "÷": Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 / op2 }),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)                       // For constants such as "π", "e", the associated value is Double
        case UnaryOperation((Double) -> Double)     // For unary operation such as "√" and "Inv", the associated value is a function
        case BinaryOperation((Double, Double) -> Double) // For binary operation such as "×", "÷", "+", and "−", the associated value is a function
        case Equals
    }

    // Initialize the calculator operation
    func initOperation() {
        setOperand(operand: "0")
        if (pendingOperation != nil) {
            pendingOperation = nil
        }
    }
    
    // Set the operand of the math operation
    func setOperand(operand: String) {
        resultOperation = Double(operand)!
    }
    
    // Execute the pending binary operation
    func doPendingOperation() {
        if (pendingOperation != nil) {
            resultOperation = pendingOperation!.binaryFunction(pendingOperation!.firstOperand, resultOperation)
            pendingOperation = nil
        }
    }
    
    // Perform the desired operation such as add, subtract, multiply, divide, and getting the result
    func performOperation(symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            case Operation.Constant(let associatedValue):
                resultOperation = associatedValue
            case Operation.UnaryOperation(let associatedFunction):
                resultOperation = associatedFunction(resultOperation)
            case Operation.BinaryOperation(let associatedFunction):
                // Execute pending binary operation
                doPendingOperation()
                // Execute current binary operation
                pendingOperation = PendingOperation(firstOperand: resultOperation, binaryFunction: associatedFunction)
            case Operation.Equals:
                // Execute pending binary operation
                doPendingOperation()
            }
        }
    }
    
    
    // Return the result of the operation
    var result: String {
        get {
            return String(resultOperation)
        }
    }
}
