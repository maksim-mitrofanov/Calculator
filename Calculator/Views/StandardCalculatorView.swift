//
//  StandardCalculatorView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 13.11.2022.
//

import SwiftUI

struct StandardCalculatorView: View {
    let isExpanded: Bool
    let currentTheme: CalculatorTheme
    
    @State private var currentNumberForUI: String = MathManager.instance.currentNumber
    
    //Used for drag gesture
    @State private var currentNumLeadingPadding: CGFloat = 0
    @State private var currentNumTrailingPadding: CGFloat = 0
    
    @StateObject private var mathManager = MathManager.instance
    
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    
    //Used for onShake action
    @AppStorage("isShakeToClearOn") private var isShakeToClearOn: Bool = false

    
    
    var body: some View {
        orientedCalculatorView
            .onChange(of: MathManager.instance.currentNumber) { _ in
                currentNumberForUI = MathManager.instance.currentNumber
            }
        
            .onChange(of: currentNumberForUI) { _ in
                if currentNumberForUI.isEmpty { currentNumberForUI = "0" }
                MathManager.instance.currentNumber = currentNumberForUI
            }
        
            .onShake {
                if isShakeToClearOn {
                    currentNumberForUI.removeAll()
                }
            }
    }
    
    var orientedCalculatorView: some View {
        VStack {
            if verticalSize == .regular { portraitOrientationView }
            else { landscapeOrientationView }
        }
    }
    
    var portraitOrientationView: some View {
        VStack(spacing: 0) {
            Spacer()

            calculationHistory
                .padding(.bottom)
                .padding(.bottom)
            
            currentNumberView
                .padding(.bottom)

            Divider()
                .padding(.bottom, isExpanded ? 20 : 0)
                .padding(.horizontal)

            SingleExtraButtonsRowView(theme: currentTheme, buttons: ButtonStorage.extraRowButtonsWithData)
                .scaleEffect(isExpanded ? 1 : 0)
                .opacity(isExpanded ? 1 : 0)
                .padding(.bottom, 10)

            StandardButtonsGrid(theme: currentTheme)
        }
    }
    
    var landscapeOrientationView: some View {
        HStack {
            VStack {
                
                calculationHistory
                    .padding(.vertical, 5)
                
                currentNumberView
                    .padding(.top, isExpanded ? 0 : 20)
                
                Spacer()
                
                if isExpanded {
                    VStack {
                        SingleExtraButtonsRowView(theme: currentTheme, buttons: ButtonStorage.extraRowButtonsWithData)
                    }
                    .transition(.scale)
                    .padding(.bottom)
                }
                
                
            }
            .padding()
            Divider()
            StandardButtonsGrid(theme: currentTheme)
        }
    }
    
    var calculationHistory: some View {
        HStack {
            Spacer()
            
            if mathManager.currentOperationHistory.isEmpty {
                Text("History is empty")
                    .font(.title3)
                    .bold()
                    .foregroundColor(currentTheme.data.operationButtonColor)
                    .minimumScaleFactor(1)
                    .opacity(0)
            }
            else {
                Text(mathManager.currentOperationHistory.joined(separator: " "))
                    .font(.title3)
                    .bold()
                    .foregroundColor(currentTheme.data.operationButtonColor)
                    .minimumScaleFactor(1)
            }
        }
        .padding(.horizontal)
    }
    
    var currentNumberView: some View {
        HStack {
            Spacer()
            
            
            HStack {
                Spacer()
                
                TextField("", text: $currentNumberForUI)
                    .multilineTextAlignment(.trailing)
                    .textSelection(.enabled)
                    .font(Font.system(size: 55))
                    .lineLimit(2)
                    .offset(x: currentNumLeadingPadding)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(currentTheme == .lightTheme ? .black : .white)
            }
            .gesture(
                DragGesture(minimumDistance: 5, coordinateSpace: .local)
                    .onChanged(currentNumberDragGestureValueChanged(to:))
                    .onEnded(currentNumberDragGestureEnded(with:))
            )
            
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
    }
    
    func currentNumberDragGestureValueChanged(to newValue: DragGesture.Value) {
        withAnimation {
            if newValue.translation.width < 0 {
                currentNumTrailingPadding = 15
            }
            else if newValue.translation.width > 0 {
                currentNumLeadingPadding = 15
            }
        }
    }
    
    func currentNumberDragGestureEnded(with newValue: DragGesture.Value) {
        withAnimation(.easeInOut(duration: 0.6)) {
            currentNumTrailingPadding = 0
            currentNumLeadingPadding = 0
        }
        
        if newValue.translation.width < 0 {
            MathManager.instance.receiveRemoveLastSwipe()
            HapticsManager.instance.impact(style: .soft)
        }
        else if newValue.translation.width > 0 {
            MathManager.instance.receiveRemoveFirstSwipe()
            HapticsManager.instance.impact(style: .soft)
        }
    }
}
