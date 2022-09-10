//
//  CurrentNumberView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 09.09.2022.
//

import SwiftUI

struct CurrentNumberView: View {
    let theme: CalculatorTheme
    let text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .lineLimit(1)
            .foregroundColor(theme.numbersTextColor)
    }
}
