//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct StandardButtonsGrid: View {
    @ObservedObject private var mathManager: MathManager = MathManager.instance
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    
    let theme: CalculatorTheme
    
    private let standardButtonsWithData = ButtonStorage.standardButtonsWithData
    private let zeroButtonData = ButtonStorage.zeroButton
    private let equalsButtonData = ButtonStorage.equalsButtons
    
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
        standardButtonsGrid
            .onChange(of: verticalSize) { newValue in
                updateScreenDimensions(using: newValue)
                updateButtonDimensions(using: newValue)
            }
            .onAppear {
                updateButtonDimensions(using: verticalSize)
            }
    }
    
    var standardButtonsGrid: some View {
        VStack(spacing: verticalSpacing) {
            ForEach(standardButtonsWithData, id: \.self) { buttonRow in
                HStack(spacing: horizontalSpacing) {
                    ForEach(buttonRow, id: \.self) { buttonData in
                        CalculatorButtonView(buttonData: buttonData, theme: theme, cornerRadius: getCornerRadius(for: buttonData), isSelected: MathManager.instance.isSelected(buttonData)) {
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
                CalculatorButtonView(buttonData: zeroButtonData, theme: theme, cornerRadius: getCornerRadius(for: zeroButtonData)) {
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
                
                CalculatorButtonView(buttonData: equalsButtonData, theme: theme, cornerRadius: getCornerRadius(for: zeroButtonData)) {
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
    
    func updateScreenDimensions(using verticalSizeValue: UserInterfaceSizeClass?) {
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
    }
}
