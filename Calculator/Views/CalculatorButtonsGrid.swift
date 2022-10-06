//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct CalculatorButtonsGrid: View {
    @ObservedObject var mathManager: MathManager
    
    let isExtraButtonRowExpanded: Bool
    let theme: CalculatorTheme
    
    private let buttonRows = ButtonStorage.mainButtonsWithData
    private let zeroButtonData = ButtonStorage.zeroButton
    private let equalsButtonData = ButtonStorage.equalsButtons
    private let extraButtons = ButtonStorage.extraRowButtonsWithData
    private let gridVerticalSpacing: CGFloat = 10
    
    var body: some View {
        VStack {
            extraButtonsGrid
                .opacity(isExtraButtonRowExpanded ? 1 : 0)
                .scaleEffect(isExtraButtonRowExpanded ? 1 : 0.8)
            mainButtonsGrid
        }
    }
    
    var extraButtonsGrid: some View {
        HStack {
            ForEach(extraButtons) { buttonData in
                StandardCalculatorButton(buttonData: buttonData, theme: theme, isSelected: mathManager.isSelected(buttonData)) {
                    mathManager.receiveButtonTap(buttonData)
                }
            }
        }
    }
    
    
    var mainButtonsGrid: some View {
        VStack {
            if #available(iOS 16.0, *) {
                Grid(verticalSpacing: gridVerticalSpacing) {
                    ForEach(buttonRows, id: \.self) { row in
                        GridRow {
                            ForEach(row) { buttonData in
                                StandardCalculatorButton(buttonData: buttonData, theme: theme, isSelected: mathManager.isSelected(buttonData)) {
                                    mathManager.receiveButtonTap(buttonData)
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
                Text("Only works on IOS 16 or later")
            }
        }
    }
    
    var zeroButton: some View {
        VStack {
            Spacer()
            
            HStack{
                StandardCalculatorButton(buttonData: zeroButtonData, theme: theme) {
                    mathManager.receiveButtonTap(zeroButtonData)
                }
                
                Spacer()
            }
        }
    }
    
    var equalsButton: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .bottom) {
                Spacer()
                
                StandardCalculatorButton(buttonData: equalsButtonData, theme: theme) {
                    mathManager.receiveButtonTap(equalsButtonData)
                }
            }
        }
    }
}

struct StandardCalculatorButton: View {
    let buttonData: CalculatorButtonData
    let theme: CalculatorTheme
    var isSelected: Bool = false
    let action: () -> Void
    
    var body: some View {
        VStack {
            if buttonData.operationType == .mathOperation {
                Button {
                    action()
                } label: {
                    StandardCalculatorButtonLabel(buttonData: buttonData, theme: theme, isSelected: isSelected)
                        .frame(width: ButtonLayout.buttonWidth(for: buttonData))
                        .frame(height: ButtonLayout.buttonHeight(for: buttonData))
                        .opacity(getButtonOpacity())
                }
                .buttonStyle(PersistedButtonStyle())
                
            } else {
                Button {
                    action()
                } label: {
                    StandardCalculatorButtonLabel(buttonData: buttonData, theme: theme, isSelected: isSelected)
                        .frame(width: ButtonLayout.buttonWidth(for: buttonData))
                        .frame(height: ButtonLayout.buttonHeight(for: buttonData))
                        .opacity(getButtonOpacity())
                }
                .buttonStyle(DefaultButtonStyle())
            }
        }
        .accessibilityIdentifier(buttonData.text)
    }
    
    func getButtonOpacity() -> CGFloat {
        if buttonData.text == "" && buttonData.imageName == "" { return 0 }
        else { return 1 }
    }
}

struct StandardCalculatorButtonLabel: View {
    let buttonData: CalculatorButtonData
    let theme: CalculatorTheme
    let isSelected: Bool
    
    private var cornerRadius: CGFloat {
        buttonData.layoutViewType == .extraOperation ? 18 : 26
    }
    
    var body: some View {
        VStack {
            if buttonData.imageName.isEmpty {
                textLabel
            } else {
                imageLabel
            }
        }
        .cornerRadius(cornerRadius)
    }
    
    var textLabel: some View {
        backgroundView
            .overlay {
                Text(buttonData.text)
                    .foregroundColor(theme.textColorFor(buttonType: buttonData.layoutViewType))
                    .font(.title)
            }
    }
    
    var imageLabel: some View {
        backgroundView
            .overlay(
                Text(Image(systemName: buttonData.imageName))
                    .foregroundColor(theme.textColorFor(buttonType: buttonData.layoutViewType))
                    .font(.title2)
            )
    }
    
    var backgroundView: some View {
        Rectangle()
            .foregroundColor(getBackroundViewColor())
    }
    
    private func getBackroundViewColor() -> Color {
        if isSelected { return theme == .lightTheme ? Color.black.opacity(0.4) : Color.white.opacity(0.7) }
        else { return theme.buttonColorFor(buttonType: buttonData.layoutViewType) }
    }
    
    private func getTextColor() -> Color {
        if isSelected { return theme == .lightTheme ? Color.white : Color.black }
        else { return theme.textColorFor(buttonType: buttonData.layoutViewType) }
    }
}

struct CalculatorButtonsGrid_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsGrid(mathManager: MathManager.instance, isExtraButtonRowExpanded: false, theme: .lightTheme)
        CalculatorButtonsGrid(mathManager: MathManager.instance, isExtraButtonRowExpanded: false, theme: .darkTheme)
    }
}
