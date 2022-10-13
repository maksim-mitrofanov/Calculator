//
//  ButtonLayoutValues.swift
//  Calculator
//
//  Created by Максим Митрофанов on 18.09.2022.
//

import SwiftUI
import Foundation

struct ButtonLayoutValues {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let buttonToScreenRatio: CGFloat = 5
    static let verticalSpacing: CGFloat = 4
    static let horizontalSpacing: CGFloat = 5
    static let mainButtons = ButtonStorage.mainButtonsWithData
    static let extraButtons = ButtonStorage.extraRowButtonsWithData
    
    static func buttonWidth(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.layoutViewType == .extraOperation {
            return screenWidth / buttonToScreenRatio
        } else {
            switch buttonData.aspectRatio {
            case 1/2: return screenWidth / (buttonToScreenRatio / 2) + horizontalSpacing * 2
            default: return screenWidth / buttonToScreenRatio
            }
        }
    }
    
    static func buttonHeight(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.layoutViewType == .extraOperation {
            return screenWidth / buttonToScreenRatio / 2
        } else {
            switch buttonData.aspectRatio {
            case 2/1: return screenWidth / (buttonToScreenRatio / 2) + horizontalSpacing * 2
            default: return screenWidth / buttonToScreenRatio
            }
        }
    }
    
    static func extraRowHeight() -> CGFloat {
        return screenWidth / buttonToScreenRatio / 2
    }
}


enum ThemeOption {
    case auto, alwaysDark, alwaysLight
}
