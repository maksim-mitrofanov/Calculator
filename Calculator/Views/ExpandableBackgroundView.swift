//
//  ExpandableBackgroundView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct ExpandableBackgroundView: View {
    @StateObject var  mathManager: MathManager
    let theme: CalculatorTheme
    let areButtonsExpanded: Bool
    
    @State private var isExpanded: Bool = true
    @State private var topOffset: CGFloat = CalcViewDefVals.minTopOffset
    
    private var minTopOffset: CGFloat { CalcViewDefVals.minTopOffset }
    private var maxTopOffset: CGFloat { CalcViewDefVals.maxTopOffset }
    private var extraOffset: CGFloat { CalcViewDefVals.extraOffset }

    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            expandableRectangle
                .overlay(pullTab)
                .overlay(calculationHistory)
                .overlay(currentNumberAndButtonGrid)
                .padding(.top, topOffset)
            
                .gesture(
                    DragGesture()
                        .onChanged(isDragGestureValueChanged(_:))
                        .onEnded(isDragGestureEnded(_:))
                )
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
    
    var currentNumberAndButtonGrid: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(mathManager.currentNumber)
                    .font(Font.system(size: 55))
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(theme == .lightTheme ? .black : .white)
                    .padding(.bottom, areButtonsExpanded ? 10 : 0)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9)

            
            CalculatorButtonsGrid(mathManager: mathManager, isExtraButtonRowExpanded: areButtonsExpanded, theme: theme)

        }
    }
    
    private func getShadowColor() -> Color {
        switch theme {
        case .lightTheme: return .black.opacity(0.1)
        case .darkTheme: return .gray.opacity(0.1)
        }
    }
    
    private func isExpandedStateChanged() {
        withAnimation {
            if isExpanded { topOffset = minTopOffset }
            else { topOffset = maxTopOffset }
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
            //ANIMATION IS NOT EVEN
            else if !isExpanded && gestureHValue < 0 {
                topOffset = max(topOffset + gestureHValue, minTopOffset)
                print("\(topOffset + gestureHValue), \(minTopOffset)")
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


