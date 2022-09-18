//
//  ButtonStorage.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 01.09.2022.
//

import Foundation


class ButtonStorage {
    static var extraRowButtonsWithData: [CalculatorButtonData] {[
           CalculatorButtonData(imageName: "x.squareroot", aspectRatio: 2/1),
           CalculatorButtonData(text: "^", aspectRatio: 2/1),
           CalculatorButtonData(imageName: "plus.forwardslash.minus", aspectRatio: 2/1),
           CalculatorButtonData(imageName: "percent", aspectRatio: 2/1)
        
    ]}
    
    static var mainButtonsWithData: [CalculatorButtonData] {[
        //Top Row
        CalculatorButtonData(text: "AC"),
        CalculatorButtonData(text: "divide", imageName: "divide"),
        CalculatorButtonData(text: "multiply", imageName: "multiply"),
        CalculatorButtonData(text: "delete", imageName: "delete.backward"),
        
        //Second Row
        CalculatorButtonData(text: "7"),
        CalculatorButtonData(text: "8"),
        CalculatorButtonData(text: "9"),
        CalculatorButtonData(text: "minus", imageName: "minus"),
        
        //Third Row
        CalculatorButtonData(text: "4"),
        CalculatorButtonData(text: "5"),
        CalculatorButtonData(text: "6"),
        CalculatorButtonData(text: "plus", imageName: "plus"),
        
        //Fourth Row
        CalculatorButtonData(text: "1"),
        CalculatorButtonData(text: "2"),
        CalculatorButtonData(text: "3"),
        CalculatorButtonData(text: "=", imageName: "equal", aspectRatio: 2/1),
        
        //Bottom Row
        CalculatorButtonData(text: "0", aspectRatio: 1/2),
        CalculatorButtonData(text: ".")
    ]}
}

struct CalculatorButtonData: Identifiable, Hashable {
    var text: String = ""
    var imageName: String = ""
    var aspectRatio: Float = 1/1
    
    var type: buttonType {
        switch text {
        case let text where CalculatorButtonData.numbers.contains(text) || text == ".": return .number
        case let text where CalculatorButtonData.operations.contains(text): return .operation
        case let text where text == "=": return .equals
        default: return .extraOperation
        }
    }
    
    let id: String = UUID().uuidString
}

extension CalculatorButtonData {
    enum buttonType {
        case number
        case operation
        case equals
        case extraOperation
    }
    
    static let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    static let operations = ["AC", "plus", "minus", "multiply", "divide", "delete"]
}
