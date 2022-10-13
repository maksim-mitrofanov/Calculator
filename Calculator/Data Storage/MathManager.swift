//
//  Math Manager.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import Foundation

struct MathOperator {
    let description: String
}

struct CalculationHistoryStruct {
    let firstOperand: Double
    let mathOperator: MathOperator
    let secondOperand: Double
    let result: Double
    
    var description: String {
        [firstOperand.description, mathOperator.description,
         secondOperand.description, "=",
         result.description]
            .joined(separator: " ")
    }
}

final class MathManager: ObservableObject {
    @Published var currentOperationHistory: [String] = []
    @Published var currentNumber: String = "0"
    @Published var currentMathOperator = ""
    
    public var allOperationsHistory: [String] = []
    private var currentOperands: [Double] = []
    private var isMathOperatorLast: Bool = false
    
    
    
    public func receiveButtonTap(_ buttonData: CalculatorButtonData) {
        if currentNumber == "Error" { cleanAll() }
        else {
            switch buttonData.operationType {
            case .number:
                receiveNumberButtonTap(buttonData: buttonData)
            case .mathOperation:
                receiveMathOperationButtonTap(buttonData: buttonData)
            case .dot:
                receiveDotButtonTap()
            case .removeLast:
                receiveRemoveLastButtonTap()
            case .allClear:
                receiveAllClearButtonTap()
            case .equals:
                receiveEqualsButtonTap()
            }
        }
    }
    
    public func isSelected(_ buttonData: CalculatorButtonData) -> Bool {
        if currentMathOperator == buttonData.text && isMathOperatorLast {
            return true
        } else { return false }
    }
    
    private func saveCurrentOperationHistory() {
        allOperationsHistory.append(currentOperationHistory.joined(separator: " ") + " = " + currentNumber)
    }
    
    private func calculateResult() -> String {
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
            output = "Error"
        }
        
        if output != "Error" {
            if Double(Int(result)) == result { output = "\(Int(result))" }
            else { output = String(result) }
        }
        
        return output
    }
    
    private func applyCurrentMathOperatorToCurrentNumber(mathOperator: CalculatorButtonData) {
        if mathOperator.usesTwoOperands == false {
            switch mathOperator.text {
            case "plus_minus":
                if currentNumber != "0" {
                    currentNumber = String((Double(currentNumber) ?? 0) * -1)
                }
            case "squareroot":
                guard let currentNumberAsDouble = Double(currentNumber) else { return }
                if currentNumberAsDouble > 0 { currentNumber = String(sqrt(currentNumberAsDouble))}
                
            case "persent":
                guard let currentNumberAsDouble = Double(currentNumber) else { return }
                currentNumber = String(currentNumberAsDouble / 100)
            default:
                print("Error")
            }
            
        }
        if currentNumber.hasSuffix(".0") { currentNumber.removeLast(2)}
    }
    
    private func cleanAll() {
        currentNumber = "0"
        currentOperationHistory.removeAll()
        currentOperands.removeAll()
        currentMathOperator.removeAll()
        allOperationsHistory.removeLast()
    }
    
    private func receiveNumberButtonTap(buttonData: CalculatorButtonData) {
        if currentOperationHistory.count > 2 { currentOperationHistory.removeAll() }
        if !isMathOperatorLast {
            if currentNumber == "0" || currentNumber == "Error" { currentNumber = buttonData.text }
            else { currentNumber.append(buttonData.text) }
        } else if isMathOperatorLast {
            if currentNumber.last == "." { currentNumber += "0" }
            currentOperands.append(Double(currentNumber) ?? 0)
            currentOperationHistory.append(currentNumber)
            currentOperationHistory.append(currentMathOperator)
            
            currentNumber = buttonData.text
            isMathOperatorLast = false
        }
    }
    
    private func receiveMathOperationButtonTap(buttonData: CalculatorButtonData) {
        if currentNumber == "Error" {
            currentNumber = "0";
            currentOperands.removeAll()
            currentOperationHistory.removeAll()
            currentMathOperator = buttonData.text
            
        }
        else if buttonData.usesTwoOperands == false {
            applyCurrentMathOperatorToCurrentNumber(mathOperator: buttonData)
        }
        else if currentMathOperator.isEmpty { currentMathOperator = buttonData.text; isMathOperatorLast = true }
        else if currentOperands.count == 1 {
            if currentNumber.last == "." { currentNumber += "0" }
            currentOperands.append(Double(currentNumber) ?? 0)
            currentOperationHistory.append(currentNumber)
            
            currentNumber = calculateResult()
            saveCurrentOperationHistory()
            
            currentOperands.removeAll()
            currentMathOperator = buttonData.text
            isMathOperatorLast = true
            
        }
        else if currentMathOperator == buttonData.text { currentMathOperator.removeAll(); isMathOperatorLast = false }
        else { currentMathOperator = buttonData.text; isMathOperatorLast = true }
        
    }
    
    private func receiveDotButtonTap() {
        if currentNumber == "Error" { currentNumber = "0."}
        else if !currentNumber.contains(".") { currentNumber.append(".") }
    }
    
    private func receiveRemoveLastButtonTap() {
        if currentNumber == "Error" { currentNumber = "0" }
        else if !currentNumber.isEmpty { currentNumber.removeLast() }
        if currentNumber.isEmpty { currentNumber = "0" }
    }
    
    private func receiveAllClearButtonTap() {
        currentNumber = "0"
        currentMathOperator.removeAll()
        currentOperands.removeAll()
        currentOperationHistory.removeAll()
        isMathOperatorLast = false
    }
    
    private func receiveEqualsButtonTap() {
        if currentNumber.last == "." { currentNumber.append("0") }
        currentOperands.append(Double(currentNumber) ?? 0)
        currentOperationHistory.append(currentNumber)
        
        currentNumber = calculateResult()
        currentOperands.removeAll()
        
        currentMathOperator.removeAll()
        isMathOperatorLast = false
        saveCurrentOperationHistory()
    }
        
    static let instance = MathManager()
    private init() { }
}
