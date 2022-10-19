//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct CalculatorButtonsGrid: View {
    @ObservedObject private var mathManager: MathManager = MathManager.instance
    
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
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private let buttonToScreenRatio: CGFloat = 5
    private let verticalSpacing: CGFloat = 4
    private let horizontalSpacing: CGFloat = 5
    private let mainButtons = ButtonStorage.mainButtonsWithData
    private let extraButtons = ButtonStorage.extraRowButtonsWithData
    
    var body: some View {
        Button {
            action()
            HapticsManager.instance.impact(style: .soft)
            SoundManager.instance.playButtonTapSound()
        } label: {
            StandardCalculatorButtonLabel(buttonData: buttonData, theme: theme, isSelected: isSelected)
        }
        .buttonStyle(AdaptiveButtonStyle(isButtonStatePersisted: buttonData.operationType == .mathOperation ? true : false))
        
        .opacity(getButtonOpacity())
        .frame(width: buttonWidth(for: buttonData))
        .frame(height: buttonHeight(for: buttonData))
        .accessibilityIdentifier(buttonData.text)
    }
    
    func getButtonOpacity() -> CGFloat {
        if buttonData.text == "" && buttonData.imageName == "" { return 0 }
        else { return 1 }
    }
    
    func buttonWidth(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.layoutViewType == .extraOperation {
            return screenWidth / buttonToScreenRatio
        } else {
            switch buttonData.aspectRatio {
            case 1/2: return screenWidth / (buttonToScreenRatio / 2) + horizontalSpacing * 2
            default: return screenWidth / buttonToScreenRatio
            }
        }
    }
    
    func buttonHeight(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.layoutViewType == .extraOperation {
            return screenWidth / buttonToScreenRatio / 2
        } else {
            switch buttonData.aspectRatio {
            case 2/1: return screenWidth / (buttonToScreenRatio / 2) + horizontalSpacing * 2
            default: return screenWidth / buttonToScreenRatio
            }
        }
    }
    
    func extraRowHeight() -> CGFloat {
        return screenWidth / buttonToScreenRatio / 2
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
                    .foregroundColor(theme.data.textColorFor(buttonType: buttonData.layoutViewType))
                    .font(.title)
            }
    }
    
    var imageLabel: some View {
        backgroundView
            .overlay(
                Text(Image(systemName: buttonData.imageName))
                    .foregroundColor(theme.data.textColorFor(buttonType: buttonData.layoutViewType))
                    .font(.title2)
            )
    }
    
    var backgroundView: some View {
        Rectangle()
            .foregroundColor(getBackroundViewColor())
    }
    
    private func getBackroundViewColor() -> Color {
        if isSelected { return theme == .lightTheme ? Color.black.opacity(0.4) : Color.white.opacity(0.7) }
        else { return theme.data.buttonColorFor(buttonType: buttonData.layoutViewType) }
    }
    
    private func getTextColor() -> Color {
        if isSelected { return theme == .lightTheme ? Color.white : Color.black }
        else { return theme.data.textColorFor(buttonType: buttonData.layoutViewType) }
    }
}

struct CalculatorButtonsGrid_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsGrid(isExtraButtonRowExpanded: false, theme: .lightTheme)
            .previewInterfaceOrientation(.portrait)
        
        CalculatorButtonsGrid(isExtraButtonRowExpanded: false, theme: .lightTheme)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
