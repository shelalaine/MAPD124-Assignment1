//
//  File Name:      CalculatorOperation.swift
//  Project Name:   MAPD124-Assignment1
//  Description:    This class handles the different math calculations such as unary and binary operations and
//                  returning the values of a specific symbol.
//
//  Created by:     Shelalaine Chan on .
//  Student ID:     300924281
//  Change History: 2017-01-13, Created
//                  2017-01-22, Add initOperation method
//                              Update the switch statement of performOperation method 
//                              Add operations variable with a Dictionary data type containing the constants 
//                                  and different operations
//                              Add comments in the binaryFunction variable
//                              Remove the operationAdd, operationSubtract, operationMultiply, and operationDivide functions
//                              Integrate the binary operation for add, subtract, multiply, and divide as a closure to its 
//                                  corresponding symbol within the operations variable
//                              Update the setOperand parameter data type from Double to String
//                              Add doPendingOperation to execute pending binary operation if not nil
//                  2017-01-23, Update operations Dictionary to include the unary operation handling of Inv and
//                                  % symbols
//
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
        "Inv": Operation.UnaryOperation({ (op1: Double) -> Double in return 1 / op1 }),
        "%": Operation.UnaryOperation({ (op1: Double) -> Double in return op1 / 100 }),
        "+/-": Operation.UnaryOperation({ (op1: Double) -> Double in return (op1 != 0) ? (op1 * -1) : 0}),
        
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
        case UnaryOperation((Double) -> Double)     // For unary operation such as "√", "Inv", "%", and "+/-", the associated value is a function
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
    
    // Perform the desired mathematical operation
    func performOperation(symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            case Operation.Constant(let associatedValue):
                //
                resultOperation = associatedValue
            case Operation.UnaryOperation(let associatedFunction):
                // 
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
            // Split the strings into the digits before and after the "." decimal sign
            let data = String(resultOperation).components(separatedBy: ".")

            if (data.count > 1) {
                // Return the whole digit(s) as a String if the decimal part is 0
                if (Double(data[1]) == 0.0) {
                    return data[0]
                }
            }
            
            // Return the entire number as a String
            return String(resultOperation)
        }
    }
}
