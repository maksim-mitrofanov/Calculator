//
//  Math Manager.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import Foundation

class MathManager: ObservableObject {    
    @Published var operationsHistory: [String] = [""]
    @Published var currentNumber: String = "0"
    @Published var result: String = ""
    
    private var isActive: Bool = true
    
    func receiveButtonTap(_ buttonData: CalculatorButtonData) {
        if isActive {
            
            switch buttonData.operationType {
            case .number:
                if currentNumber != "0" { currentNumber.append(buttonData.text) }
                else { currentNumber = buttonData.text }
                
            case .mathOperation:
                operationsHistory.append(currentNumber)
                operationsHistory.append(buttonData.text)
                currentNumber.removeAll()
                
            case .dot:
                if !currentNumber.contains(".") { currentNumber.append(".")}
                
            case .removeLast:
                currentNumber.removeLast()
                
            case .allClear:
                currentNumber.removeAll()
                operationsHistory.removeAll()
                
            case .equals:
                print("equals")
            }
            
            if currentNumber.isEmpty { currentNumber.append("0") }
        }
    }
    
    func toggleMathModuleState() {
        isActive.toggle()
    }
    
//    func calculateResult() {
//        var mathOperators = ["+"]
//        var currentResult: Double = 0
//        var currentOperator: String = ""
//        
//        for data in operationsHistory {
//            if operators.contains(data) {
//                currentOperator = data
//            } else {
//                switch currentOperator {
//                case "+":
//                    currentResult += Double(data) ?? 0
//                case "-":
//                    currentResult -= Double(data) ?? 0
//                case "*":
//                    currentResult *= Double(data) ?? 0
//                case "/":
//                    currentResult /= Double(data) ?? 0
//                default:
//                    currentResult = Double(data) ?? 0
//                }
//            }
//        }
//    }
}
