//
//  CurrentCalculationHistory.swift
//  Calculator
//
//  Created by Максим Митрофанов on 18.09.2022.
//

import SwiftUI

struct CurrentCalculationHistory: View {
    let text: String
    let theme: CalculatorTheme
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(theme.operationButtonColor)
    }
}

struct CurrentCalculationHistory_Previews: PreviewProvider {
    static var previews: some View {
        CurrentCalculationHistory(text: "123", theme: .lightTheme)
    }
}
