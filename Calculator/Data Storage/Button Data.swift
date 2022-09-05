//
//  Button Data.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import Foundation

struct CalculatorButtonData: Identifiable, Hashable {
    var text: String = ""
    var imageName: String = ""
    var aspectRatio: Float = 1/1
    let id: String = UUID().uuidString
    
    
    var type: buttonType {
        switch text {
        case let text where numbers.contains(text): return .number
        case let text where text == "=": return .equals
        default: return .operation
        }
    }
}

extension CalculatorButtonData {
    enum buttonType {
        case number
        case operation
        case equals
    }
    
    private var numbers: [String] { ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."] }
}
