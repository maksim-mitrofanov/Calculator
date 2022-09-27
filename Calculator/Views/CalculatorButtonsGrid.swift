//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct CalculatorButtonsGrid: View {
    @StateObject var mathManager: MathManager = MathManager()
    let isExpanded: Bool
    let theme: CalculatorTheme
    
    let buttonRows = ButtonStorage.mainButtonsWithData
    let zeroButtonData = ButtonStorage.zeroButton
    let equalsButtonData = ButtonStorage.equalsButtons
    let extraButtons = ButtonStorage.extraRowButtonsWithData
    
    var body: some View {
        VStack {
            Spacer()
            extraButtonsGrid
                .opacity(isExpanded ? 1 : 0)
                .scaleEffect(isExpanded ? 1 : 0.8)
            mainButtonsGrid
        }
    }
    
    var extraButtonsGrid: some View {
        HStack {
            ForEach(extraButtons) { button in
                Button {
                    mathManager.receiveButtonTap(button)
                } label: {
                    CalculatorButtonLabel(buttonData: button, theme: theme)
                        .foregroundColor(.black)
                        .frame(width: ButtonLayout.buttonWidth(for: button))
                        .frame(height: ButtonLayout.buttonHeight(for: button))
                }
            }
        }
    }
    
    
    var mainButtonsGrid: some View {
        VStack {
            if #available(iOS 16.0, *) {
                Grid {
                    ForEach(buttonRows, id: \.self) { row in
                        GridRow {
                            ForEach(row) { buttonData in
                                Button {
                                    mathManager.receiveButtonTap(buttonData)
                                } label: {
                                    CalculatorButtonLabel(buttonData: buttonData, theme: theme)
                                        .aspectRatio(1/1, contentMode: .fit)
                                        .frame(width: ButtonLayout.buttonWidth(for: buttonData))
                                        .frame(height: ButtonLayout.buttonHeight(for: buttonData))
                                        .opacity(buttonData.text == "" ? 0 : 1)
                                }
                            }
                        }
                    }
                }
                .overlay(
                    zeroButton
                )
                .overlay(
                    equalsButton
                )
            } else {
                // Fallback on earlier versions
                Text("")
            }
        }
//        .background(Rectangle().stroke())
    }
    
    var zeroButton: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack{
                    Button {
                        mathManager.receiveButtonTap(zeroButtonData)
                    } label: {
                        CalculatorButtonLabel(buttonData: zeroButtonData, theme: theme)
                            .frame(width: ButtonLayout.buttonWidth(for: zeroButtonData))
                            .frame(height: ButtonLayout.buttonHeight(for: zeroButtonData))
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    var equalsButton: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button {
                        mathManager.receiveButtonTap(equalsButtonData)
                    } label: {
                        CalculatorButtonLabel(buttonData: equalsButtonData, theme: theme)
                            .frame(width: ButtonLayout.buttonWidth(for: equalsButtonData))
                            .frame(height: ButtonLayout.buttonHeight(for: equalsButtonData))
                    }
                }
            }
        }
    }
}

