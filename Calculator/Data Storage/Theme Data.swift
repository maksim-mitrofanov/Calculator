//
//  CalculatorTheme.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI
import Foundation

struct CalculatorTheme: Equatable {
    var numberButtonColor: Color
    var operationButtonColor: Color
    var equalsButtonColor: Color
    
    var numbersTextColor: Color
    var operationTextColor: Color
    var equalsTextColor: Color
    
    var backgroundColor: Color
    
    func buttonColorFor(buttonType: CalculatorButtonData.buttonType) -> Color {
        switch buttonType {
        case .operation: return operationButtonColor
        case .number: return numberButtonColor
        case .equals: return equalsButtonColor
        }
    }
    
    func textColorFor(buttonType: CalculatorButtonData.buttonType) -> Color {
        switch buttonType {
        case .operation: return operationTextColor
        case .number: return numbersTextColor
        case .equals: return equalsTextColor
        }
    }
}

