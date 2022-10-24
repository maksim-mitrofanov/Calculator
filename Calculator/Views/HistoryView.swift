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
    
    let minBannerOffset: CGFloat = UIScreen.main.bounds.height * 0.35
    let maxBannerOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var bannerYOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    
    @State private var isBannerFaceUP: Bool = false
    
    @State var timeRemaining = 2
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            if calculationsHistory.isEmpty {
                emptyHistoryView
            } else {
                historyListView
                    .onReceive(timer) { _ in
                        if isBannerFaceUP && bannerYOffset == minBannerOffset {
                            timeRemaining -= 1
                            if timeRemaining == 0 {
                                timeRemaining = 3
                                withAnimation {
                                    bannerYOffset = maxBannerOffset
                                    isBannerFaceUP = false
                                }
                            }
                        }
                    }
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
            Color(uiColor: .systemGroupedBackground)
                .aspectRatio(8/1, contentMode: .fit)
                .overlay{
                    Text("Tap to copy")
                }
            
            List {
                ForEach(calculationsHistory, id: \.self) { historyRow in
                    Text(historyRow)
                        .onTapGesture {
                            withAnimation {
                                copyToClipboard(from: historyRow)
                            }
                        }
                }
            }
            .overlay {
                TextCopiedBanner(isFaceUP: $isBannerFaceUP, numberCopied: copiedValue.description, delay: 0.3)
                    .gesture(
                        DragGesture(minimumDistance: 5)
                            .onChanged(textCopiedBannerGestureValueChanged(value:))
                            .onEnded(textCopiedBannerGestureEnded(value:))
                    )
                    .offset(y: bannerYOffset)
            }
        }
    }
    
    func textCopiedBannerGestureValueChanged(value: DragGesture.Value) {
        withAnimation {
            if value.translation.height > 0 {
                bannerYOffset += value.translation.height
            }
        }
    }
    
    func textCopiedBannerGestureEnded(value: DragGesture.Value) {
        withAnimation(.easeInOut(duration: 1)) {
            if value.translation.height > 2 {
                bannerYOffset = maxBannerOffset
                isBannerFaceUP = false
            } else {
                bannerYOffset = minBannerOffset
            }
        }
    }
    
    func copyToClipboard(from row: String) {
        guard let equalsIndex = row.firstIndex(where: { $0 == "=" })
        else { return  }
        var lastNumber = row.suffix(from: equalsIndex)
        lastNumber.removeFirst(2)
        
        changeBannerState()
        pasteboard.string = lastNumber.description
        copiedValue = lastNumber.description
        
    }
    
    func changeBannerOffset() {
        if bannerYOffset == minBannerOffset { bannerYOffset = maxBannerOffset }
        else { bannerYOffset = minBannerOffset }
    }
    
    func rotateBanner() {
        isBannerFaceUP.toggle()
    }
    
    func changeBannerState() {
        withAnimation {
            if bannerYOffset == maxBannerOffset {
                changeBannerOffset(); isBannerFaceUP = false }
            if !isBannerFaceUP { isBannerFaceUP = true }
        }
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
