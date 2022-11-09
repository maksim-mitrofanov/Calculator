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
    
    
    var body: some View {
        ZStack {
            theme.data.backgroundColor.edgesIgnoringSafeArea(.all)
            
            if verticalSize == .regular {
                VStack {
                    Text("Portrait")
                    dismissButton
                    
                }
            }
            
            else {
                VStack {
                    Text("Landscape")
                    dismissButton
                    
                }
            }
        }
        .preferredColorScheme(getCurrentColorScheme())
    }
    
    var verticalOrientationView: some View {
        VStack(spacing: 0) {
            Text("Tap to copy result")
                .foregroundColor(theme.data.numbersTextColor)
                .font(.title3)
                .bold()
            
            historyListView
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
                        .foregroundColor(theme.data.numbersTextColor)
                    
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
                Text(historyRow)
                    .foregroundColor(theme.data.numbersTextColor)
                    .onTapGesture {
                        withAnimation {
                            copyToClipboard(from: historyRow)
                        }
                    }
            }
            .listRowBackground(Color(uiColor: .secondarySystemFill))
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
                .background(.ultraThinMaterial)
                .cornerRadius(12)
        }
    }
    
    func copyToClipboard(from row: String) {
        guard let equalsIndex = row.firstIndex(where: { $0 == "=" })
        else { return  }
        var lastNumber = row.suffix(from: equalsIndex)
        lastNumber.removeFirst(2)
        
        withAnimation {
            pasteboard.string = lastNumber.description
            copiedValue = lastNumber.description
        }
    }
    
    
    func getCurrentColorScheme() -> ColorScheme{
        if theme == .lightTheme { return .light }
        else { return .dark }
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
