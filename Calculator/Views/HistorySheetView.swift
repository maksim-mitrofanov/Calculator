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
    
    //Timer
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemainingForBanner = 3
    
    var body: some View {
        ZStack {
            //History View according to Device Orientation
            theme.data.backgroundColor.edgesIgnoringSafeArea(.all)
            if verticalSize == .regular {
                verticalOrientationView
            }
            
            else {
                horizontalOrientationView
            }
        }
        .preferredColorScheme(getCurrentColorScheme())
        .onReceive(timer) { _ in
            timerPublishedOneSecond()
        }
    }
    
    var verticalOrientationView: some View {
        VStack {
            HStack {
                Text("History")
                    .foregroundColor(theme.data.numbersTextColor)
                    .font(.largeTitle.bold())
                    .scaleEffect(1.2)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.top)
            
            if MathManager.instance.allOperationsHistory.isEmpty {
                EmptyHistorySheetView(theme: theme, screenWidth: screenWidth, screenHeight: screenHeight)
            }
            
            else {
                historyListView
                
                Spacer()
                
                if copiedValue != "" {
                    TextCopiedBanner(isFaceUP: .constant(true), numberCopied: copiedValue, theme: theme)
                        .transition(.move(edge: .bottom))
                }
            }
            
        }
        .padding(.vertical)
    }
    
    var horizontalOrientationView: some View {
        VStack {
            HStack(alignment: .top) {
                historyListView
                
                Spacer()
                
                VStack(spacing: 0) {
                    if copiedValue == "" || copiedValue.isEmpty {
                        Text("Tap to copy result")
                            .foregroundColor(theme.data.numbersTextColor)
                            .font(.title3)
                            .bold()
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .top)))
                        
                    }
                    
                    if copiedValue.count > 0 {
                        Text("Value copied: " + copiedValue)
                            .foregroundColor(theme.data.numbersTextColor)
                            .font(.title3)
                            .bold()
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .top)))
                        

                    }
                    
                    LottieView(fileName: "LottieCopyAnim")
                        .frame(width: 200, height: 200)
                    
                    dismissButton
                        .offset(y: -20)
                    
                    Spacer()
                    
                }
                .padding(.top)
                .padding(.top)
                
                .frame(width: screenWidth * 0.4)
                
                
            }
        }
    }
    
    var historyListView: some View {
        List {
            ForEach(calculationsHistory, id: \.self) { historyRow in
                HStack {
                    Text(historyRow)
                        .foregroundColor(theme.data.numbersTextColor)
                    Spacer()
                    
                    Button {
                        withAnimation {
                            copyToClipboard(from: historyRow)
                        }
                    } label: {
                        Image(systemName: "doc.on.doc")
                            .font(.title3)
                    }
                }
            }
            .listRowBackground(theme.data.numberButtonColor.opacity(0.5))
        }
        .scrollContentBackground(.hidden)
        .frame(maxWidth: verticalSize == .regular ? screenWidth : screenWidth * 0.6)
    }
    
    var dismissButton: some View {
        Button {
            withAnimation {
                dismiss()
            }
        } label: {
            Text("Dismiss")
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
        }
    }
       
    func copyToClipboard(from row: String) {
        guard let equalsIndex = row.firstIndex(where: { $0 == "=" })
        else { return  }
        var lastNumber = row.suffix(from: equalsIndex)
        
        lastNumber.removeFirst(2)
        
        copiedValue = lastNumber.description
        pasteboard.string = copiedValue
    }
    
   
    
    func getCurrentColorScheme() -> ColorScheme{
        if theme == .lightTheme { return .light }
        else { return .dark }
    }
    
    func timerPublishedOneSecond() {
        withAnimation {
            if timeRemainingForBanner > 0 && copiedValue != "" { timeRemainingForBanner -= 1 }
            if timeRemainingForBanner == 0 { copiedValue = "" }
        }
    }
}

struct HistorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(tab: .history)
    }
}
