//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct CalculatorButtonsView: View {
    let isExpanded: Bool
    let theme: CalculatorTheme
    
    var body: some View {
        VStack {
            Spacer()
            ExtraButtonsGridView(mathManager: MathManager(), theme: theme)
                .opacity(isExpanded ? 1 : 0)
                .scaleEffect(isExpanded ? 1 : 0.8)
            MainButtonsGridView(mathManager: MathManager(), theme: theme)
        }
    }
}

struct CalculatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsView(isExpanded: true, theme: .lightTheme)
    }
}
