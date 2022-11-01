//
//  ButtonStorage.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 01.09.2022.
//

import Foundation


class ButtonStorage {
    static let extraRowButtonsWithData: [CalculatorButtonData] = [
        CalculatorButtonData(
            text: "√",
            imageName: "x.squareroot",
            aspectRatio: 2/1,
            operationType: .mathOperation,
            usesTwoOperands: false
        ),
        
        CalculatorButtonData(
            text: "^",
            imageName: "control",
            aspectRatio: 2/1,
            operationType: .mathOperation
        ),
        
        CalculatorButtonData(
            text: "plus_minus",
            imageName: "plus.forwardslash.minus",
            aspectRatio: 2/1,
            operationType: .mathOperation,
            usesTwoOperands: false
        ),
        
        CalculatorButtonData(
            text: "persent",
            imageName: "percent",
            aspectRatio: 2/1,
            operationType: .mathOperation,
            usesTwoOperands: false)
    ]
    
    static let mainButtonsWithData: [[CalculatorButtonData]] = [
        [
        //Top Row
        CalculatorButtonData(text: "AC", operationType: .allClear),
        CalculatorButtonData(text: "/", imageName: "divide", operationType: .mathOperation),
        CalculatorButtonData(text: "x", imageName: "multiply", operationType: .mathOperation),
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
        CalculatorButtonData(text: "3", operationType: .number),
        CalculatorButtonData(text: "", operationType: .number)
        ],
        
        [
        //Bottom Row
        CalculatorButtonData(text: "", operationType: .number),
        CalculatorButtonData(text: "", operationType: .number),
        CalculatorButtonData(text: ".", operationType: .dot),
        CalculatorButtonData(text: "", operationType: .number)
        ]
    ]
    
    static let zeroButton: CalculatorButtonData =
        CalculatorButtonData(text: "0", aspectRatio: 1/2, operationType: .number)
    
    
    static let equalsButtons: CalculatorButtonData =
        CalculatorButtonData(text: "=", imageName: "equal", aspectRatio: 2/1, operationType: .equals)
    
}

struct CalculatorButtonData: Identifiable, Hashable {
    var text: String = ""
    var imageName: String = ""
    var aspectRatio: Float = 1/1
    var operationType: CalculatorButtonOperationType
    var layoutViewType: CalculatorButtonViewType { CalculatorButtonData.getButtonViewType(text) }
    var usesTwoOperands: Bool = true
    let id: String = UUID().uuidString
}

extension CalculatorButtonData {
    static let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    static let operations = ["AC", "+", "-", "x", "/", "delete"]
    
    static func getButtonViewType(_ text: String) -> CalculatorButtonViewType {
        switch text {
            
        case let text where numbers.contains(text) || text == "." : return .number
        case let text where operations.contains(text): return .operation
        case let text where text == "=": return .equals
        default: return .extraOperation
        }
    }
}

enum CalculatorButtonViewType {
    case number
    case operation
    case equals
    case extraOperation
}


enum CalculatorButtonOperationType {
    case number
    case mathOperation
    case removeLast
    case allClear
    case dot
    case equals
}
