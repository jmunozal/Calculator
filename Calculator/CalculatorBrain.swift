//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jesús Muñoz on 14/09/2017.
//  Copyright © 2017 Jesús Muñoz. All rights reserved.
//

// model! (WHAT)

import Foundation


struct CalculatorBrain {
    
    // No initialiser: struc automatically sets initialise vars
    private var accumulator: Double?
    
    private enum Operation {
        case Constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> =  [
        "π": Operation.Constant(Double.pi), // pi
        "e": Operation.Constant(M_E), // m_e
        "√": Operation.unaryOperation(sqrt), // sqrt
        "cos": Operation.unaryOperation(cos), // cos
        "±": Operation.unaryOperation({ -$0 }),
        "×": Operation.binaryOperation({$0 * $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "-": Operation.binaryOperation({$0 - $1}),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
                break
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                }
                case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    
    // muttating can change value of the struct
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
