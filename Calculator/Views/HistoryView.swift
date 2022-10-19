//
//  CalculationsHistoryView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 06.10.2022.
//

import SwiftUI

struct HistoryView: View {
    let theme: CalculatorTheme
    var calculationsHistory: [String] = MathManager.instance.allOperationsHistory
    
    private let pasteboard = UIPasteboard.general
    @State private var copiedValue: String = ""
    @State private var isCopiedBannerShown: Bool = false
    
    var minBannerOffset: CGFloat = UIScreen.main.bounds.height * 0.4
    var maxBannerOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    var bannerYOffset: CGFloat {
        copiedValue == "" ? maxBannerOffset : minBannerOffset
    }
    
    var body: some View {
        VStack {
            if calculationsHistory.isEmpty {
                emptyHistoryView
            } else {
                historyListView
            }
        }
        .preferredColorScheme(theme == .lightTheme ? .light : .dark)
    }
    
    var emptyHistoryView: some View {
        Text("Calculation history is empty.")
            .padding()
    }
    
    var historyListView: some View {
        VStack(spacing: 0) {
            List {
                ForEach(calculationsHistory, id: \.self) { historyRow in
                    Text(historyRow)
                        .onTapGesture {
                            withAnimation {
                                copyToClipboard(getResultAsString(from: historyRow))
                                copiedValue = getResultAsString(from: historyRow)
                            }
                            
                        }
                }
            }
            .overlay {
                TextCopiedBanner(numberCopied: copiedValue)
                    .offset(y: bannerYOffset)
            }
        }
    }
   
    func copyToClipboard(_ value: String){
        pasteboard.string = value
    }
    
    func getResultAsString(from row: String) -> String {
        guard let equalsIndex = row.firstIndex(where: { $0 == "=" })
        else { return "" }
        var lastNumber = row.suffix(from: equalsIndex)
        lastNumber.removeFirst(2)
        
        return lastNumber.description
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
