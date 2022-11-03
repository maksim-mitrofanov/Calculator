//
//  ExpandableBackgroundView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct ExpandableBackgroundView: View {
    let theme: CalculatorTheme
    
    @State private var isExpanded: Bool = true
    @State private var topOffset: CGFloat = CalcViewDefVals.minTopOffset
    @StateObject private var mathManager: MathManager = MathManager.instance
    
    private var minTopOffset: CGFloat { CalcViewDefVals.minTopOffset }
    private var maxTopOffset: CGFloat { CalcViewDefVals.maxTopOffset }
    private var extraOffset: CGFloat { CalcViewDefVals.extraOffset }

    
    var body: some View {
        ZStack(alignment: .top) {
            
            expandableRectangle
                .overlay(pullTab)
                .overlay(calculationHistory)
                .padding(.top, topOffset)
            
                .gesture(
                    DragGesture()
                        .onChanged(isDragGestureValueChanged(_:))
                        .onEnded(isDragGestureEnded(_:))
                )
        }
        .onChange(of: isExpanded) { newValue in
            print("Is background expanded: \(newValue.description)")
        }
    }
    
    var expandableRectangle: some View {
        RoundedRectangle(cornerRadius: CalcViewDefVals.cornerRadius)
            .foregroundColor(theme.data.backgroundColor)
            .shadow(color: getShadowColor(), radius: CalcViewDefVals.shadowRadius)
            .edgesIgnoringSafeArea(.bottom)
    }
    
    var pullTab: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 8)
                .frame(width: 48)
                .foregroundColor(.gray.opacity(0.6))

            Spacer()
        }
        .padding(.top)
        .padding(.top)
    }
    
    var calculationHistory: some View {
        VStack {
            HStack {
                Spacer()

                Text(mathManager.currentOperationHistory.joined(separator: " "))
                    .font(.headline)
                    .foregroundColor(theme.data.operationButtonColor)
                    .padding()
                    .padding()
                    .padding(.top)
            }
            Spacer()
        }
    }
    
    private func getShadowColor() -> Color {
        switch theme {
        case .lightTheme: return .black.opacity(0.1)
        case .darkTheme: return .gray.opacity(0.1)
        }
    }
    
    private func isDragGestureValueChanged(_ value: DragGesture.Value) {
        let gestureHValue = value.translation.height
        
        
        withAnimation {
            if isExpanded && gestureHValue < 0 {
                topOffset = max(gestureHValue, minTopOffset - extraOffset)
            }
            else if isExpanded && gestureHValue > 0 {
                topOffset = min(gestureHValue, maxTopOffset + extraOffset)
            }
            else if !isExpanded && gestureHValue > 0 {
                topOffset = min(topOffset + gestureHValue, maxTopOffset + extraOffset)
            }
            else if !isExpanded && gestureHValue < 0 {
                topOffset = max(topOffset + gestureHValue, minTopOffset)
            }
        }
    }
    
    private func isDragGestureEnded(_ value: DragGesture.Value) {
        let gestureHValue = value.translation.height
        
        if isExpanded && gestureHValue < 0 {
            withAnimation {
                topOffset = minTopOffset
                isExpanded = true
            }
        }
        else if isExpanded && gestureHValue > 0 {
            withAnimation {
                topOffset = maxTopOffset
                isExpanded = false
            }
        }
        else if !isExpanded && gestureHValue > 0 {
            withAnimation {
                topOffset = maxTopOffset
                isExpanded = false
            }
        }
        else if !isExpanded && gestureHValue < 0 {
            withAnimation {
                topOffset = minTopOffset
                isExpanded = true
            }
        }
    }
}


