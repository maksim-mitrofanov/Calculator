//
//  SingleExtraButtonsRowView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 03.11.2022.
//

import SwiftUI

struct SingleExtraButtonsRowView: View {
    @ObservedObject private var mathManager: MathManager = MathManager.instance
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    
    let theme: CalculatorTheme
    let buttons: [CalculatorButtonData]
    
    //Determines Screen Dimensions
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    //Standard button Dimensions
    @State private var singleButtonWidth: CGFloat = 0
    @State private var singleButtonHeight: CGFloat = 0
    
    //Button Grid spacing values
    @State private var horizontalSpacing: CGFloat = 0
    
    var body: some View {
        HStack {
            ForEach(buttons) { buttonData in
                CalculatorButton(buttonData: buttonData, theme: theme, cornerRadius: 18, isSelected: MathManager.instance.isSelected(buttonData)) {
                    MathManager.instance.receiveButtonTap(buttonData)
                }
                .frame(width: singleButtonWidth)
                .frame(height: singleButtonHeight)
            }
        }
        .onAppear { updateButtonDimensions(using: verticalSize) }
        .onChange(of: verticalSize) { newValue in
            updateScreenDimensions(using: newValue)
            updateButtonDimensions(using: newValue)
        }
    }
    
    func updateButtonDimensions(using verticalSize: UserInterfaceSizeClass?) {
        if verticalSize == .regular {
            singleButtonWidth = screenWidth / ButtonLayoutValues.PortraitVerticalSpaceToButtonWidthRatio
            singleButtonHeight = screenWidth / ButtonLayoutValues.PortraitVerticalSpaceToButtonHeightRatio / 1.8
            
            horizontalSpacing = screenWidth / ButtonLayoutValues.VerticalSpaceToHorizontalSpacingRatio
        }
        
        else {
            singleButtonWidth = screenHeight / ButtonLayoutValues.LandscapeVerticalSpaceToButtonWidthRatio
            singleButtonHeight = singleButtonWidth / 1.8
            
            horizontalSpacing = screenHeight / ButtonLayoutValues.VerticalSpaceToHorizontalSpacingRatio
        }
    }
    
    func updateScreenDimensions(using verticalSizeValue: UserInterfaceSizeClass?) {
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
    }

}

struct SingleExtraButtonsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SingleExtraButtonsRowView(theme: .lightTheme, buttons: ButtonStorage.extraRowButtonsWithDataShort)
    }
}
