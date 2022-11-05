//
//  Math Manager.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import Foundation

final class MathManager: ObservableObject {
    @Published var currentOperationHistory: [String] = []
    @Published var currentNumber: String = "0"
    @Published var currentMathOperator = ""
    
    public var allOperationsHistory: [String] = []
    private var currentOperands: [Double] = []
    private var isMathOperatorLast: Bool = false
    
    private var errorText = "Error"
        
    public func receiveButtonTap(_ buttonData: CalculatorButtonData) {
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
        
//        print("Operation History: \(currentOperationHistory)")
//        print("Current Number: \(currentNumber)")
//        print("Current Math Operator: \(currentMathOperator)")
//        print("Current Operands: \(currentOperands)")
//        print("Is Math Operator Last: \(isMathOperatorLast)\n")
    }
        
   
    

    //MARK: -Receive Taps
    private func receiveNumberButtonTap(buttonData: CalculatorButtonData) {
        //Cleans operations history
        if currentOperationHistory.count > 2 { currentOperationHistory.removeAll() }
        
        
        if isMathOperatorLast {
            appendCurrentNumberToOperands(setResult: false)
            currentOperationHistory.append(currentMathOperator)
            
            currentNumber = buttonData.text
            isMathOperatorLast = false
        }
        
        else if !isMathOperatorLast {
            if currentNumber == "0" || currentNumber == errorText { currentNumber = buttonData.text }
            else { currentNumber.append(buttonData.text) }
        }
    }
    
    private func receiveMathOperationButtonTap(buttonData: CalculatorButtonData) {
        if currentNumber == errorText {
            cleanAll()
            currentMathOperator = buttonData.text
            isMathOperatorLast = true
        }
        
        else {
            appendZeroAfterDot()
            
            //applies current math operator to current number
            if buttonData.usesTwoOperands == false {
                if currentOperands.count == 0 && buttonData.text.count == 1 { currentOperationHistory.append(buttonData.text)
                }
                applyCurrentMathOperatorToCurrentNumber(mathOperator: buttonData)
                
                print("1")
            }
            
            //appends current number to operands and sets current math operator
            else if currentOperands.count == 1 {
                appendCurrentNumberToOperands(setResult: true)
                currentMathOperator = buttonData.text
                isMathOperatorLast = true
                
                print("2")
            }
            
            //deselects current math operator
            else if currentMathOperator == buttonData.text {
                currentMathOperator.removeAll(); isMathOperatorLast = false
                
                print("3")
            }
            
            //sets currentMathOperator
            else {
                //exception for math operators with single operand
                if currentMathOperator == "√" || currentMathOperator == "%" { saveCurrentOperationHistory() }
                
                currentOperationHistory.removeAll()
                currentMathOperator = buttonData.text; isMathOperatorLast = true
                
                print("4")

            }
        }
    }
    
    private func receiveDotButtonTap() {
        if currentNumber == errorText { currentNumber = "0."}
        else if !currentNumber.contains(".") { currentNumber.append(".") }
    }
    
    private func receiveRemoveLastButtonTap() {
        if currentNumber == errorText { currentNumber = "0" }
        
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
        if currentOperands.count != 0 {
            appendCurrentNumberToOperands(setResult: true)
            
            currentMathOperator.removeAll()
            isMathOperatorLast = false
        }
    }
    
    
    //MARK: -Private helper funs
    private func calculateResult() -> String {
        var result: Double = 0
        var output: String = ""
        
        switch currentMathOperator {
        case "+": result = currentOperands[0] + currentOperands[1]
        case "-": result = currentOperands[0] - currentOperands[1]
        case "x": result = currentOperands[0] * currentOperands[1]
        case "/":
            if currentOperands[1] == 0 { output = errorText }
            else { result = currentOperands[0] / currentOperands[1] }
        case "^": result = pow(currentOperands[0], currentOperands[1])
            
        default:
            output = errorText
        }
        
        if output != errorText {
            output = Double(round(1000 * result) / 1000).description
        }
        
        if output.hasSuffix(".0") { output.removeLast(2)}
        
        return output
    }
    
    private func appendZeroAfterDot() {
        if currentNumber.last == "." { currentNumber.append("0") }
    }
    
    private func appendCurrentNumberToOperands(setResult: Bool) {
        //Checks if number can be converted to double
        if currentNumber.last == "." { currentNumber.append("0") }
        guard let currentNumberAsDouble = Double(currentNumber) else { return }
        
        
        currentOperands.append(currentNumberAsDouble)
        currentOperationHistory.append(currentNumber)
        
        if setResult == true {
            if currentOperands.count == 2 {
                currentNumber = calculateResult()
                saveCurrentOperationHistory()
                currentOperands.removeAll()
            }
        }
    }
    
    private func applyCurrentMathOperatorToCurrentNumber(mathOperator: CalculatorButtonData) {
        guard let currentNumberAsDouble = Double(currentNumber) else { return }

        switch mathOperator.text {
        case "plus_minus":
            if currentNumber != "0" {
                currentNumber = String(currentNumberAsDouble * -1)
            }
        case "√":
            if currentNumberAsDouble > 0 {
                currentOperationHistory.removeAll()
                currentOperationHistory.append("√" + currentNumber)
                currentNumber = String(sqrt(currentNumberAsDouble))
                currentMathOperator = "√"
            }
            
        case "%":
            if currentOperands.count == 1 {
                currentOperationHistory.append(currentNumber)
                currentOperationHistory.append("%")
                let percentageFromNumber = String((currentOperands[0] ) / 100 * currentNumberAsDouble)
                currentOperands.append(Double(percentageFromNumber) ?? 0)
                
                currentNumber = calculateResult()
                saveCurrentOperationHistory()
                currentOperands.removeAll()
                
            } else {
                currentNumber = String(currentNumberAsDouble / 100)
            }
            
        default:
            print(errorText)
        }
 
        if currentNumber.hasSuffix(".0") { currentNumber.removeLast(2)}
    }
    
    private func cleanAll() {
        currentNumber = "0"
        currentOperationHistory.removeAll()
        currentOperands.removeAll()
        currentMathOperator.removeAll()
    }
    
    private func saveCurrentOperationHistory() {
        allOperationsHistory.append(currentOperationHistory.joined(separator: " ") + " = " + currentNumber )
    }

    
    
    
    //MARK: -Public
    public func isSelected(_ buttonData: CalculatorButtonData) -> Bool {
        if currentMathOperator == buttonData.text && isMathOperatorLast {
            return true
        } else { return false }
    }
    
    public func receiveRemoveLastSwipe() { receiveRemoveLastButtonTap() }

    public func receiveRemoveFirstSwipe() {
        if currentNumber.count > 2  {
            currentNumber.removeFirst()
            
            guard let firstChar = currentNumber.first else { return }
            if firstChar == "." { currentNumber = "0" + currentNumber }
        }
    }
        
    static let instance = MathManager()
    private init() { }
}
