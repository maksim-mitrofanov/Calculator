//
//  ExtraButtonsGridView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 16.09.2022.
//

import SwiftUI

struct ExtraButtonsGridView: View {
    @State var mathManager: MathManager
    let theme: CalculatorTheme
    let buttons: [CalculatorButtonData] = ButtonStorage.extraRowButtonsWithData
    
    var body: some View {
        HStack {
            ForEach(buttons) { button in
                Button {
                    mathManager.receiveButtonTap(button)
                } label: {
                    CalculatorButtonLabel(buttonData: button, theme: theme)
                        .foregroundColor(.black)
                        .frame(width: ButtonLayout.buttonWidth(for: button))
                        .frame(height: ButtonLayout.buttonHeight(for: button))
                }
            }
        }
//        .background(Rectangle().stroke())
    }
}
