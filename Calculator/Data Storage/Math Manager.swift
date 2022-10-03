//
//  Math Manager.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import Foundation

class MathManager: ObservableObject {    
    @Published var operationsHistory: [String] = []
    @Published var currentNumber: String = "0"
    @Published var currentMathOperator = ""
    @Published var currentOperands: [Double] = []
    @Published var isMathOperatorLastPressed: Bool = false
            
    func receiveButtonTap(_ buttonData: CalculatorButtonData) {
        switch buttonData.operationType {
            
        case .number:
            if currentNumber != "0" && !isMathOperatorLastPressed { currentNumber.append(buttonData.text) }
            else { currentNumber = buttonData.text }
            isMathOperatorLastPressed = false
            
        case .mathOperation:
            //Count result and update output values
            if currentOperands.count == 2 {
                currentNumber = calculateResult();
                currentOperands.removeAll()
                currentOperands.append(Double(currentNumber) ?? 0)
                currentMathOperator = buttonData.text
            }
            
            //Deselect math operator
            else if currentMathOperator == buttonData.text && currentOperands.isEmpty {
                currentMathOperator.removeAll()
            }
                
            //Set new math operator
            else if currentOperands.count == 1 && currentOperands[0] == Double(currentNumber) {
                currentMathOperator = buttonData.text
            }
                
            //Add curent number to math operands, set current math operator
            else {
                if currentNumber.last == "." { currentNumber.append("0") }
                else if currentNumber.isEmpty { currentNumber = "0" }
                
                currentOperands.append(Double(currentNumber) ?? 0)
                currentNumber = "0"
                currentMathOperator = buttonData.text
            }
            
            //Count result and update output values
            if currentOperands.count == 2 {
                currentNumber = calculateResult()
                currentOperands.removeAll()
                currentOperands.append(Double(currentNumber) ?? 0)
            }
            
            isMathOperatorLastPressed = true
            

            
            
        case .dot:
            if !currentNumber.contains(".") { currentNumber.append(".") }
            
        case .removeLast:
            if !currentNumber.isEmpty { currentNumber.removeLast() }
            if currentNumber.isEmpty { currentNumber = "0" }
            
        case .allClear:
            currentNumber = "0"
            currentOperands.removeAll()
            currentMathOperator.removeAll()
            
            isMathOperatorLastPressed = false
                        
        case .equals:
            if currentNumber.isEmpty { currentNumber = "0" }
            currentOperands.append(Double(currentNumber) ?? 0)
            currentNumber = calculateResult()
            currentOperands.removeAll()
            currentMathOperator.removeAll()
            
            isMathOperatorLastPressed = false
                        
        }
        
        
        print("OPREATIONS HISTORY: \(operationsHistory)")
        print("CURRENT OPERANDS: \(currentOperands)")
        print("CURRENT MATH OPERATOR: \(currentMathOperator)")
        print("CURRENT NUMBER: \(currentNumber)")
        print("~~~~~~~~~~~~~~~~")
    }
    
    func isSelected(_ buttonData: CalculatorButtonData) -> Bool {
        if currentMathOperator == buttonData.text && isMathOperatorLastPressed {
            return true
        } else { return false }
    }
    
    func calculateResult() -> String {
        var result: Double = 0
        var output: String = ""
        
        switch currentMathOperator {
        case "+": result = currentOperands[0] + currentOperands[1]
        case "-": result = currentOperands[0] - currentOperands[1]
        case "x": result = currentOperands[0] * currentOperands[1]
        case "/":
            if currentOperands[1] == 0 { output = "Error" }
            else { result = currentOperands[0] / currentOperands[1] }
        case "^": result = pow(currentOperands[0], currentOperands[1])
            
        default:
            print("Error")
        }
        
        if output != "Error" {
            if Double(Int(result)) == result { output = "\(Int(result))" }
            else { output = String(result) }
        }
        
        return output
    }
    
    static let MathOperators = ["+", "-", "x", "/", "^"]
    
    static let instance = MathManager()
    private init() { }
}
