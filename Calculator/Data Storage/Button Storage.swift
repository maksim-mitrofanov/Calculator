//
//  ButtonStorage.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 01.09.2022.
//

import Foundation


class ButtonStorage {
    static var extraRowButtonsWithData: [CalculatorButtonData] {[
        CalculatorButtonData(imageName: "x.squareroot", aspectRatio: 2/1, operationType: .mathOperation),
        CalculatorButtonData(text: "^", aspectRatio: 2/1, operationType: .mathOperation),
        CalculatorButtonData(imageName: "plus.forwardslash.minus", aspectRatio: 2/1, operationType: .mathOperation),
        CalculatorButtonData(imageName: "percent", aspectRatio: 2/1, operationType: .mathOperation)
        
    ]}
    
    static var mainButtonsWithData: [[CalculatorButtonData]] {[
        [
        //Top Row
        CalculatorButtonData(text: "AC", operationType: .clear),
        CalculatorButtonData(text: "/", imageName: "divide", operationType: .mathOperation),
        CalculatorButtonData(text: "*", imageName: "multiply", operationType: .mathOperation),
        CalculatorButtonData(text: "delete", imageName: "delete.backward", operationType: .removeLast)
        ],
        
        [
        //Second Row
        CalculatorButtonData(text: "7", operationType: .number),
        CalculatorButtonData(text: "8", operationType: .number),
        CalculatorButtonData(text: "9", operationType: .number),
        CalculatorButtonData(text: "-", imageName: "minus", operationType: .mathOperation),
        ],
        
        [
        //Third Row
        CalculatorButtonData(text: "4", operationType: .number),
        CalculatorButtonData(text: "5", operationType: .number),
        CalculatorButtonData(text: "6", operationType: .number),
        CalculatorButtonData(text: "+", imageName: "plus", operationType: .mathOperation),
        ],
        
        [
        //Fourth Row
        CalculatorButtonData(text: "1", operationType: .number),
        CalculatorButtonData(text: "2", operationType: .number),
        CalculatorButtonData(text: "3", operationType: .number)
        ],
        
        [
        //Bottom Row
        CalculatorButtonData(text: "", operationType: .number),
        CalculatorButtonData(text: "", operationType: .number),
        CalculatorButtonData(text: ".", operationType: .dot)
        ]
    ]}
    
    static var zeroButton: CalculatorButtonData {
        CalculatorButtonData(text: "0", aspectRatio: 1/2, operationType: .number)
    }
    
    static var equalsButtons: CalculatorButtonData {
        CalculatorButtonData(text: "=", imageName: "equal", aspectRatio: 2/1, operationType: .equals)
    }
}

struct CalculatorButtonData: Identifiable, Hashable {
    var text: String = ""
    var imageName: String = ""
    var aspectRatio: Float = 1/1
    var operationType: buttonOperationType
    var layoutViewType: buttonViewType { CalculatorButtonData.getButtonViewType(text) }
    
    
    let id: String = UUID().uuidString
}

extension CalculatorButtonData {
    enum buttonViewType {
        case number
        case operation
        case equals
        case extraOperation
    }
}

extension CalculatorButtonData {
    enum buttonOperationType {
        case number
        case mathOperation
        case removeLast
        case clear
        case dot
        case equals
    }
}

extension CalculatorButtonData {
    static func getButtonViewType(_ text: String) -> buttonViewType {
        let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        let operations = ["AC", "+", "-", "*", "/", "delete"]
        
        switch text {
        case let text where numbers.contains(text) || text == "." : return .number
        case let text where operations.contains(text): return .operation
        case let text where text == "=": return .equals
        default: return .extraOperation
        }
    }
}
