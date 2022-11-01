//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct CalculatorButtonsGrid: View {
    @ObservedObject private var mathManager: MathManager = MathManager.instance
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    
    let isExtraButtonRowExpanded: Bool
    let theme: CalculatorTheme
    
    private let mainButtonsData = ButtonStorage.mainButtonsWithData
    private let zeroButtonData = ButtonStorage.zeroButton
    private let equalsButtonData = ButtonStorage.equalsButtons
    private let extraButtonsData = ButtonStorage.extraRowButtonsWithData
    
    //Determines Screen Dimensions
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    //Standard button Dimensions
    @State private var singleButtonWidth: CGFloat = 0
    @State private var singleButtonHeight: CGFloat = 0
    
    //Button Grid spacing values
    @State private var verticalSpacing: CGFloat = 0
    @State private var horizontalSpacing: CGFloat = 0
    
    var buttonColumnsData: [GridItem] {
        return [
            GridItem(.fixed(singleButtonWidth)),
            GridItem(.fixed(singleButtonWidth)),
            GridItem(.fixed(singleButtonWidth)),
            GridItem(.fixed(singleButtonWidth))
        ]
    }
    
    
    var body: some View {
        VStack {
            mainButtonsGrid
        }
        .onChange(of: verticalSize) { newValue in
            screenWidth = UIScreen.main.bounds.width
            screenHeight = UIScreen.main.bounds.height
            
            updateButtonDimensions(using: newValue)
        }
        .onAppear {
            updateButtonDimensions(using: verticalSize)
        }
    }
    
    var extraButtonsGrid: some View {
        HStack {
            ForEach(extraButtonsData) { buttonData in
                StandardCalculatorButton(buttonData: buttonData, theme: theme, cornerRadius: getCornerRadius(for: buttonData), isSelected: mathManager.isSelected(buttonData)) {
                    mathManager.receiveButtonTap(buttonData)
                }
                .frame(width: singleButtonWidth)
                .frame(height: singleButtonHeight / 2)
            }
        }
    }
    
    
    var mainButtonsGrid: some View {
        VStack(spacing: verticalSpacing) {
            ForEach(mainButtonsData, id: \.self) { buttonRow in
                HStack(spacing: horizontalSpacing) {
                    ForEach(buttonRow, id: \.self) { buttonData in
                        StandardCalculatorButton(buttonData: buttonData, theme: theme, cornerRadius: getCornerRadius(for: buttonData), isSelected: MathManager.instance.isSelected(buttonData)) {
                            MathManager.instance.receiveButtonTap(buttonData)
                        }
                        .frame(width: singleButtonWidth)
                        .frame(height: singleButtonHeight)
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
    
    var zeroButton: some View {
        VStack {
            Spacer()
            
            HStack{
                StandardCalculatorButton(buttonData: zeroButtonData, theme: theme, cornerRadius: getCornerRadius(for: zeroButtonData)) {
                    mathManager.receiveButtonTap(zeroButtonData)
                }
                .frame(width: singleButtonWidth * 2 + horizontalSpacing)
                .frame(height: singleButtonHeight)
                
                Spacer()
            }
        }
    }
    
    var equalsButton: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .bottom) {
                Spacer()
                
                StandardCalculatorButton(buttonData: equalsButtonData, theme: theme, cornerRadius: getCornerRadius(for: zeroButtonData)) {
                    mathManager.receiveButtonTap(equalsButtonData)
                }
                .frame(width: singleButtonWidth)
                .frame(height: singleButtonHeight * 2 + verticalSpacing)
            }
        }
    }
    
    func getCornerRadius(for buttonData: CalculatorButtonData) -> CGFloat {
        if verticalSize == .regular {
            return (screenWidth / 14).rounded()
        }
        
        else {
            return screenHeight / 16
        }
    }
    
    func updateButtonDimensions(using verticalSizeValue: UserInterfaceSizeClass?) {
        if verticalSizeValue == .regular {
            singleButtonWidth = screenWidth / ButtonLayoutValues.PortraitVerticalSpaceToButtonWidthRatio
            singleButtonHeight = screenWidth / ButtonLayoutValues.PortraitVerticalSpaceToButtonHeightRatio
            
            verticalSpacing = screenWidth / ButtonLayoutValues.VerticalSpaceToVerticalSpacingRatio
            horizontalSpacing = screenWidth / ButtonLayoutValues.VerticalSpaceToHorizontalSpacingRatio
        }
        
        else {
            singleButtonWidth = screenHeight / ButtonLayoutValues.LandscapeVerticalSpaceToButtonWidthRatio
            singleButtonHeight = screenHeight / ButtonLayoutValues.LandscapeVerticalSpaceToButtonHeightRatio
            
            verticalSpacing = screenHeight / ButtonLayoutValues.VerticalSpaceToVerticalSpacingRatio
            horizontalSpacing = screenHeight / ButtonLayoutValues.VerticalSpaceToHorizontalSpacingRatio
        }
    }
}

struct StandardCalculatorButton: View {
    let buttonData: CalculatorButtonData
    let theme: CalculatorTheme
    let cornerRadius: CGFloat
    
    var isSelected: Bool = false
    let action: () -> Void
    
    private let mainButtons = ButtonStorage.mainButtonsWithData
    private let extraButtons = ButtonStorage.extraRowButtonsWithData
    
    var body: some View {
        Button {
            action()
            HapticsManager.instance.triggerNotification(for: buttonData)
            SoundManager.instance.playButtonTapSound()
            
        } label: {
            StandardCalculatorButtonLabel(buttonData: buttonData, theme: theme, isSelected: isSelected, cornerRadius: cornerRadius)
        }
        .buttonStyle(
            AdaptiveButtonStyle(
                type: buttonData.layoutViewType == .number ? .coloured : .regular,
                cornerRadius: cornerRadius,
                isButtonStatePersisted:
                    buttonData.operationType == .mathOperation ? true : false)
        )
        
        .opacity(getButtonOpacity())
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
    let cornerRadius: CGFloat
    
    
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
            .foregroundColor(getBackgroundViewColor())
    }
    
    private func getBackgroundViewColor() -> Color {
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
