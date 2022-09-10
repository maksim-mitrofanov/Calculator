//
//  Math Manager.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import Foundation

struct CalculatorOutputData: Identifiable {
    enum DataType { case numberData, operatorData }
    
    var text: String
    let id: String = UUID().uuidString
    
    var type: DataType {
        switch text {
        case let text where CalculatorOutputData.operators.contains(text): return DataType.operatorData
        default: return DataType.numberData
        }
    }
    
    static let operators = ["+", "-", "/", "*"]
}

class MathManager: ObservableObject {
    @Published var outputData: [CalculatorOutputData] = [CalculatorOutputData(text: "0")]

    


    
    func receiveButtonTap(_ buttonText: String) {
        
    }
    
    func receiveNumberButtonTap(_ text: String) {
        print("Received Number")
    }
    
    func receiveOperatorButtonTap(_ text: String) {
        print("Received Operator")
    }
    
    func receiveSpecialButtonTap(_ text: String) {
        print("Received Special")
    }
}
