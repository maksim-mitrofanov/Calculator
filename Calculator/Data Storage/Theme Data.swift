//
//  CalculatorTheme.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI
import Foundation

enum CalculatorTheme {
    case lightTheme, darkTheme
    
    var data: CalculatorThemeData {
        switch self {
        case .lightTheme:
            return CalculatorThemeData.lightTheme
        case .darkTheme:
            return CalculatorThemeData.darkTheme
        }
    }
}

struct CalculatorThemeData: Equatable {
    var numberButtonColor: Color
    var operationButtonColor: Color
    var equalsButtonColor: Color
    
    var numbersTextColor: Color
    var operationTextColor: Color
    var equalsTextColor: Color
    
    var backgroundColor: Color
    
    func buttonColorFor(buttonType: CalculatorButtonViewType) -> Color {
        switch buttonType {
        case .operation: return operationButtonColor
        case .number: return numberButtonColor
        case .equals: return equalsButtonColor
        case .extraOperation: return operationButtonColor
        }
    }
    
    func textColorFor(buttonType: CalculatorButtonViewType) -> Color {
        switch buttonType {
        case .operation: return operationTextColor
        case .number: return numbersTextColor
        case .equals: return equalsTextColor
        case .extraOperation: return operationTextColor
        }
    }
}

extension CalculatorThemeData {
    static let lightTheme = CalculatorThemeData(
        numberButtonColor: Color(red: 236, green: 236, blue: 236),
        operationButtonColor: Color(red: 215, green: 215, blue: 215),
        equalsButtonColor: Color(red: 255, green: 203, blue: 130),
        
        numbersTextColor: Color.black,
        operationTextColor: Color.black,
        equalsTextColor: Color.black,
        
        backgroundColor: Color.white
    )

    static let darkTheme = CalculatorThemeData(
        numberButtonColor: Color(red: 50, green: 50, blue: 50),
        operationButtonColor: Color(red: 135, green: 135, blue: 135),
        equalsButtonColor: Color(red: 197, green: 128, blue: 48),
        
        numbersTextColor: Color.white,
        operationTextColor: Color.black,
        equalsTextColor: Color.black,
        
        backgroundColor: Color(red: 35, green: 35, blue: 35)
    )
}
