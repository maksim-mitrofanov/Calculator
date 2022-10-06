//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    @State private var isExtraButtonsRowExpanded: Bool = false
    @State private var isBackgroundExpanded: Bool = true
    @State private var currentTheme: CalculatorTheme = .lightTheme
    @State private var isHistorySheetPresented: Bool = false 
    
    @StateObject private var mathManager = MathManager.instance
        
    var body: some View {
        ZStack {
            backgroundColorFill
            TopBarButtons(isHistorySheetPresented: $isHistorySheetPresented,isExtraButtonsRowExpanded: $isExtraButtonsRowExpanded, theme: $currentTheme)
            ExpandableBackgroundView(mathManager: mathManager, theme: currentTheme, areButtonsExpanded: isExtraButtonsRowExpanded)
        }
        .sheet(isPresented: $isHistorySheetPresented) {
            CalculationsHistoryView(calculationsHistory: mathManager.allOperationsHistory, theme: currentTheme)
        }
    }
    
    var backgroundColorFill: some View {
        Rectangle()
            .foregroundColor(currentTheme.backgroundColor)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

struct CalcViewDefVals {
    static let cornerRadius: CGFloat = 42
    static let shadowRadius: CGFloat = 25
    
    static let screenHeight = UIScreen.main.bounds.height
    static let minTopOffset = screenHeight / 40
    static let maxTopOffset = screenHeight / 9
    static let extraOffset: CGFloat = 20
}
