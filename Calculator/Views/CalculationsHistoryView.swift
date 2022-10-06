//
//  CalculationsHistoryView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 06.10.2022.
//

import SwiftUI

struct CalculationsHistoryView: View {
    let calculationsHistory: [String]
    let theme: CalculatorTheme
    
    var body: some View {
        VStack {
            if calculationsHistory.isEmpty {
                Text("Calculation history is empty.")
                    .padding()
            } else {
                List {
                    ForEach(calculationsHistory, id: \.self) { historyRow in
                        Text(historyRow)
                    }
                }
            }
        }
        .preferredColorScheme(theme == .lightTheme ? .light : .dark)
    }
}

struct CalculationsHistoryView_Previews: PreviewProvider {
    static var isSheetShown: Bool = true
    static var previews: some View {
        CalculatorView()
            .sheet(isPresented: .constant(isSheetShown)) {
                CalculationsHistoryView(calculationsHistory: ["152 * 12 = 1824", "1824 / 2 = 917", "917 - 117 = 800", "800 / 200 = 4", "4 ^ 2 = 16"], theme: .lightTheme)
            }
    }
}
