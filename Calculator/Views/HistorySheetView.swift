//
//  CalculationsHistoryView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 06.10.2022.
//

import SwiftUI
import Lottie

struct HistorySheetView: View {
    let theme: CalculatorTheme
    var calculationsHistory: [String] = MathManager.instance.allOperationsHistory
    
    //Lets sheet view dismiss itself
    @Environment(\.dismiss) var dismiss
    
    //Determines Device Orientation
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    
    //Determines Screen Dimensions
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    //Allows to copy values to pasteboard
    private let pasteboard = UIPasteboard.general
    @State private var copiedValue: String = ""
    
    //Banner Values
    @State private var isCopiedBannerShown: Bool = false
    @State private var isBannerFaceUP: Bool = false
    
    //Banner Offset
    @State private var bannerYOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    
    //Timer
    @State private var timeRemainingForBanner = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            //Empty History
            if calculationsHistory.isEmpty {
                EmptyHistorySheetView(theme: theme, screenWidth: screenWidth, screenHeight: screenHeight)
            }
            
            //History View according to Device Orientation
            else {
                if verticalSize == .regular {
                    verticalOrientationView
                }
                
                else {
                    horizontalOrientationView
                }
            }
        }
        .onReceive(timer) { _ in
            if isBannerFaceUP {
                timeRemainingForBanner -= 1
                
                if timeRemainingForBanner == 0 {
                    withAnimation {
                        rotateBanner()
                        changeBannerOffset()
                    }
                    timeRemainingForBanner = 3
                }
                
            }
        }
        
        //Updates screenWidth and screenHeight when Device Orientation Changes
        .onChange(of: verticalSize) { newValue in
            screenWidth = UIScreen.main.bounds.width
            screenHeight = UIScreen.main.bounds.height
        }
        
    }
    
    var verticalOrientationView: some View {
        VStack(spacing: 0) {
            Text("Tap to copy result")
                .font(.title3)
                .bold()
            
            historyListView
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
        .padding(.vertical)
    }
    
    var horizontalOrientationView: some View {
        VStack {
            HStack(alignment: .top) {
                historyListView
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(copiedValue == "" ? "Tap to copy result" : copiedValue + " was copied")
                        .font(.title3)
                        .bold()
                    
                    LottieView(fileName: "LottieCopyAnim")
                        .frame(width: 200, height: 200)
                    
                    dismissButton
                        .offset(y: -20)
                    
                }
                .padding(.top)
                .padding(.top)
                
                .frame(maxWidth: screenWidth * 0.3)
                
                
            }
        }
    }
    
    var historyListView: some View {
        List {
            ForEach(calculationsHistory, id: \.self) { historyRow in
                Text(historyRow)
                    .onTapGesture {
                        withAnimation {
                            copyToClipboard(from: historyRow)
                        }
                    }
            }
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
        }
        .scrollContentBackground(.hidden)
        .frame(maxWidth: verticalSize == .regular ? screenWidth : screenWidth * 0.6)
    }
    
    var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Dismiss")
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)
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
                bannerYOffset = maxBannerYOffset()
                isBannerFaceUP = false
            } else {
                bannerYOffset = minBannerYOffset()
            }
        }
    }
    
    func copyToClipboard(from row: String) {
        guard let equalsIndex = row.firstIndex(where: { $0 == "=" })
        else { return  }
        var lastNumber = row.suffix(from: equalsIndex)
        lastNumber.removeFirst(2)
        
        withAnimation {
            changeBannerState()
            pasteboard.string = lastNumber.description
            copiedValue = lastNumber.description
        }
    }
    
    func changeBannerOffset() {
        if bannerYOffset == minBannerYOffset() { bannerYOffset = maxBannerYOffset() }
        else { bannerYOffset = minBannerYOffset() }
    }
    
    func rotateBanner() {
        isBannerFaceUP.toggle()
    }
    
    func changeBannerState() {
        withAnimation {
            if bannerYOffset == maxBannerYOffset() {
                changeBannerOffset(); isBannerFaceUP = false }
            if !isBannerFaceUP { isBannerFaceUP = true }
        }
    }
    
    func minBannerYOffset() -> CGFloat {
        if verticalSize == .regular {
            return UIScreen.main.bounds.height * 0.35
        }
        
        else {
            return UIScreen.main.bounds.width * 0.35
        }
    }
    
    func maxBannerYOffset() -> CGFloat {
        if verticalSize == .regular {
            return UIScreen.main.bounds.height * 0.8
        }
        
        else {
            return UIScreen.main.bounds.width * 0.8
        }
    }
    
    func timerPublishedOneSecondMark(_ date: Date) {
        if isBannerFaceUP && bannerYOffset == minBannerYOffset() {
            timeRemainingForBanner -= 1
            if timeRemainingForBanner == 0 {
                timeRemainingForBanner = 3
                withAnimation {
                    bannerYOffset = maxBannerYOffset()
                    isBannerFaceUP = false
                }
            }
        }
    }
}

struct HistorySheetView_Previews: PreviewProvider {
    static var isSheetShown: Bool = true
    static var previews: some View {
        CalculatorView()
            .sheet(isPresented: .constant(isSheetShown)) {
                HistorySheetView(theme: .lightTheme, calculationsHistory: ["152 * 12 = 1824", "1824 / 2 = 917", "917 - 117 = 800", "800 / 200 = 4", "4 ^ 2 = 16"])
            }
    }
}
