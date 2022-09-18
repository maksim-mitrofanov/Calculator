//
//  ExtraButtonsGridView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 16.09.2022.
//

import SwiftUI

struct ExtraButtonsGridView: View {
    let theme: CalculatorTheme
    
    private let buttons = ButtonStorage.extraRowButtonsWithData
    
    var body: some View {
        HStack(spacing: ButtonLayout.horizontalSpacing * 2) {
            ForEach(buttons) { button in
                Button {
                    
                } label: {
                    CalculatorButtonLabel(buttonData: button, theme: theme)
                        .foregroundColor(.black)
                        .frame(width: ButtonLayout.buttonWidth(for: button))
                        .frame(height: ButtonLayout.buttonHeight(for: button))
                }
            }
        }
        .padding(.top)
    }
}
