//
//  ButtonsGridView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

struct ButtonsGridView: View {
    let screenWidth = UIScreen.main.bounds.width
    let buttons = ButtonStorage().buttonsWithData
    let spacing: CGFloat = 3
    var theme: CalculatorTheme = CalculatorThemeStorage().lightTheme
    
    var body: some View {
        WrappingHStack(models: buttons, horizontalSpacing: spacing, verticalSpacing: spacing) { buttonData in
            Button {
                
            } label: {
                CalculatorButtonLabel(buttonData: buttonData, screenWidth: screenWidth, spacing: spacing, theme: theme)
                    .foregroundColor(.black)
            }
        }
    }
}

struct ButtonGrid_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsGridView(theme: CalculatorThemeStorage().lightTheme)
        ButtonsGridView(theme: CalculatorThemeStorage().darkTheme)
    }
}
