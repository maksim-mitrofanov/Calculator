//
//  Math Manager.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import Foundation

class MathManager: ObservableObject {
    @Published var operationsHistory: [String] = ["123 + 256 - 142"]
    @Published var currentNumber: String = "0"

    func receiveButtonTap(_ buttonData: CalculatorButtonData) {
        if buttonData.imageName.contains("delete") {
            if currentNumber != "0" { currentNumber.removeLast() }
            if currentNumber == "" { currentNumber.append("0") }
            
            
        } else if buttonData.text == "AC" {
            currentNumber = "0"
            operationsHistory.removeAll()
            
            
        } else if MathManager.numbers.contains(buttonData.text) {
            if currentNumber == "0" { currentNumber = buttonData.text }
            else { currentNumber.append(buttonData.text) }
            
            
        } else if buttonData.layoutViewType == .extraOperation || buttonData.layoutViewType == .operation {
            operationsHistory.append(currentNumber)
            operationsHistory.append(buttonData.text)
            currentNumber = "0"
        }
        
        print(currentNumber)
        print(buttonData)
    }
    
    static let mathOperators = ["+", "-"]
    static let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
}
