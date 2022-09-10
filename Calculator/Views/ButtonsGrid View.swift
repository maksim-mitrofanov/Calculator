//
//  ButtonsGridView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

struct ButtonsGridView: View {
    @StateObject private var mathManager = MathManager()
    
    let buttonStorage: ButtonStorage
    let theme: CalculatorTheme
    let geometryProxy: GeometryProxy
    
    private let buttonToScreenRatio = 5.0
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            extraButtonsView
            WrappingHStack(
                models: buttonStorage.mainButtonsWithData,
                horizontalSpacing: spacing,
                verticalSpacing: spacing, geometryProxy: geometryProxy
            ) { buttonData in
                Button {
                    mathManager.receiveButtonTap(buttonData.text)
                } label: {
                    CalculatorButtonLabel(buttonData: buttonData, theme: theme)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth(for: buttonData))
                        .frame(height: buttonHeight(for: buttonData))
                }
            }
        }
    }
    
    var extraButtonsView: some View {
        HStack {
        if buttonStorage.isExpanded {
                ForEach(buttonStorage.extraRowButtonsWithData) { button in
                    CalculatorButtonLabel(buttonData: button, theme: theme)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth(for: button))
                        .frame(height: buttonHeight(for: button))
                }
            }
        }
    }
    
    func buttonWidth(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.type == .extraOperation {
            return geometryProxy.size.width / buttonToScreenRatio
        } else {
            switch buttonData.aspectRatio {
            case 1/2: return geometryProxy.size.width / (buttonToScreenRatio / 2) + spacing * 2
            default: return geometryProxy.size.width / buttonToScreenRatio
            }
        }
    }
    
    func buttonHeight(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.type == .extraOperation {
            return geometryProxy.size.width / buttonToScreenRatio / 2
        } else {
            switch buttonData.aspectRatio {
            case 2/1: return geometryProxy.size.width / (buttonToScreenRatio / 2) + spacing * 2
            default: return geometryProxy.size.width / buttonToScreenRatio
            }
        }
    }
}
