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
    
    private var minTopOffset: CGFloat { CalcViewDefVals.minTopOffset }
    private var maxTopOffset: CGFloat { CalcViewDefVals.maxTopOffset }
    private var extraOffset: CGFloat { CalcViewDefVals.extraOffset }

    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            expandableRectangle
                .overlay(pullTab)
                .padding(.top, topOffset)
            
                .gesture(
                    DragGesture()
                        .onChanged { value in
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
                        .onEnded { value in
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
                            else { }
                        }
                        
                )
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
}

struct ExpandableBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableBackgroundView(theme: .lightTheme)
    }
}
