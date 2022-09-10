//
//  ButtonsGridView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

struct ButtonsGridView: View {
    @StateObject private var mathManager = MathManager()
    
    let buttons: [CalculatorButtonData]
    let theme: CalculatorTheme
    
    
    let screenRect = UIScreen.main.bounds
    let screenWidth = UIScreen.main.bounds.width
    
    private let buttonToScreenRatio = 5.0
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            WrappingHStack(models: buttons, horizontalSpacing: spacing, verticalSpacing: spacing, inRect: screenRect) { buttonData in
                Button {
                    mathManager.receiveButtonTap(buttonData.text)
                } label: {
                    CalculatorButtonLabel(buttonData: buttonData, theme: theme)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth(for: buttonData))
                        .frame(height: buttonHeight(for: buttonData))
                }
            }
            .background(
                Rectangle()
                    .stroke()
            )
        }
    }
    
    func buttonWidth(for buttonData: CalculatorButtonData) -> CGFloat {
        switch buttonData.aspectRatio {
        case 1/2: return screenWidth / (buttonToScreenRatio / 2) + spacing * 2
        default: return screenWidth / buttonToScreenRatio
        }
    }
    
    func buttonHeight(for buttonData: CalculatorButtonData) -> CGFloat {
        switch buttonData.aspectRatio {
        case 2/1: return screenWidth / (buttonToScreenRatio / 2) + spacing * 2
        default: return screenWidth / buttonToScreenRatio
        }
    }
    
    func singleRowWidth() -> CGFloat {
        (screenWidth / buttonToScreenRatio) * 4 + (8 * 4)
    }
}
