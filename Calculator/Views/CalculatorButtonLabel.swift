//
//  CalculatorButtonLabel.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 03.09.2022.
//

import SwiftUI

struct CalculatorButtonLabel: View {
    let buttonData: CalculatorButtonData
    let screenWidth: CGFloat
    let spacing: CGFloat
    let theme: CalculatorTheme
    private let buttonToScreenRatio = 4.8
    
    var width: CGFloat {
        switch buttonData.aspectRatio {
        case 1/2: return screenWidth / (buttonToScreenRatio / 2) + spacing * 2
        default: return screenWidth / buttonToScreenRatio
        }
    }
    
    var height: CGFloat {
        switch buttonData.aspectRatio {
        case 2/1: return screenWidth / (buttonToScreenRatio / 2) + spacing * 2
        default: return screenWidth / buttonToScreenRatio
        }
    }
    
    
    var body: some View {
        Rectangle()
            .foregroundColor(theme.buttonColorFor(buttonType: buttonData.type))
            .frame(width: width, height: height)
        
            .overlay(
                Text(buttonData.text)
                    .foregroundColor(theme.textColorFor(buttonType: buttonData.type))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            )
            .cornerRadius(25)
    }
}
