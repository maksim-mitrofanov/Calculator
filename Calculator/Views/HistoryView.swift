//
//  CalculationsHistoryView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 06.10.2022.
//

import SwiftUI

struct HistoryView: View {
    private let pasteboard = UIPasteboard.general
    let theme: CalculatorTheme
    var calculationsHistory: [String] = MathManager.instance.allOperationsHistory
    
    @State private var copiedValue: String = ""
    
    var body: some View {
        VStack {
            if calculationsHistory.isEmpty {
                Text("Calculation history is empty.")
                    .padding()
            } else {
                VStack(spacing: 0) {
                    Color(uiColor: .secondarySystemBackground)
                        .overlay(
                            Text(copiedValue == "" ? "Tap to copy result" : "🌟 Successfully copied \(copiedValue)")
                                .padding(.top)
                        )
                        .aspectRatio(8/1, contentMode: .fit)

                    List {
                        ForEach(calculationsHistory, id: \.self) { historyRow in
                            Text(historyRow)
                                .onTapGesture {
                                    copyToClipboard(from: historyRow)
                                }
                        }
                    }
                }
            }
        }
        .preferredColorScheme(theme == .lightTheme ? .light : .dark)
    }
    
   
    
    func copyToClipboard(from row: String) {
        guard let equalsIndex = row.firstIndex(where: { $0 == "=" })
        else { return }
        var lastNumber = row.suffix(from: equalsIndex)
        lastNumber.removeFirst(2)
        
        pasteboard.string = lastNumber.description
        copiedValue = lastNumber.description
    }
}

struct CalculationsHistoryView_Previews: PreviewProvider {
    static var isSheetShown: Bool = true
    static var previews: some View {
        CalculatorView()
            .sheet(isPresented: .constant(isSheetShown)) {
                HistoryView(theme: .lightTheme, calculationsHistory: ["152 * 12 = 1824", "1824 / 2 = 917", "917 - 117 = 800", "800 / 200 = 4", "4 ^ 2 = 16"])
            }
    }
}
