//
//  ExpandableBackgroundView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct ExpandableBackgroundView: View {
    let theme: CalculatorTheme
    let areButtonsExpanded: Bool
    
    @StateObject private var mathManager: MathManager = MathManager()
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
                .overlay(backgroundOverlay)
                .overlay(mathManagerDisableButton)

                .padding(.top, topOffset)
            
                .gesture(
                    DragGesture()
                        .onChanged(isDragGestureValueChanged(_:))
                        .onEnded(isDragGestureEnded(_:))
                )
        }
    }
    
    var mathManagerDisableButton: some View {
        VStack {
            HStack {
                Button {
                    mathManager.toggleMathModuleState()
                } label: {
                    AdditionalButtonLabel(imageName: "minus.plus.batteryblock", theme: theme)
                }
                .padding()
                
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    var expandableRectangle: some View {
        RoundedRectangle(
            cornerRadius: CalcViewDefVals.cornerRadius)
            .foregroundColor(theme.backgroundColor)
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
                
                Text(mathManager.operationsHistory.joined(separator: " "))
                    .font(.headline)
                    .foregroundColor(theme.operationButtonColor)
                    .padding()
                    .padding()
                    .padding(.top)
            }
            Spacer()
        }
    }
    
    var backgroundOverlay: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Spacer()
            Text(mathManager.currentNumber)
                .font(Font.system(size: 55))
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .padding(.bottom, areButtonsExpanded ? 10 : 0)
                .padding(.bottom, isExpanded ? 10 : 0)
            
            CalculatorButtonsGrid(mathManager: mathManager, isExtraButtonRowExpanded: areButtonsExpanded, theme: theme)

        }
    }
    
    private func getShadowColor() -> Color {
        switch theme {
        case .lightTheme: return .black.opacity(0.1)
        case .darkTheme: return .gray.opacity(0.1)
        default:
            return .black
        }
    }
    
    private func isExpandedStateChanged() {
        withAnimation {
            if isExpanded { topOffset = minTopOffset }
            else { topOffset = maxTopOffset }
        }
    }
    
    private func isDragGestureValueChanged(_ value: DragGesture.Value) {
        let gestureHValue = value.translation.height / 1.2
        
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


