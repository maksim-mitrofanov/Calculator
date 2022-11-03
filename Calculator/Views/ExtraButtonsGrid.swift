//
//  ExtraButtonsGrid.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 02.11.2022.
//

import SwiftUI

struct ExtraButtonsGrid: View {
    @ObservedObject private var mathManager: MathManager = MathManager.instance
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    
    let theme: CalculatorTheme
    
    //Determines Screen Dimensions
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    //Standard button Dimensions
    @State private var singleButtonWidth: CGFloat = 0
    @State private var singleButtonHeight: CGFloat = 0
    
    //Button Grid spacing values
    @State private var verticalSpacing: CGFloat = 0
    @State private var horizontalSpacing: CGFloat = 0

    private let extraButtonsWithDataShort = ButtonStorage.extraRowButtonsWithDataShort
    private let extraButtonsWithDataAll: [[CalculatorButtonData]] = []

    
    var body: some View {
        orientedExtraButtonsGrid
            .onAppear { updateButtonDimensions(using: verticalSize) }
            .onChange(of: verticalSize) { newValue in
                updateScreenDimensions(using: newValue)
                updateButtonDimensions(using: newValue)
            }
    }
    
    var orientedExtraButtonsGrid: some View {
        VStack {
            if verticalSize == .regular { portraitOrientedView }
            else { landscapeOrientedView }
        }
    }
    
    var landscapeOrientedView: some View {
        VStack {
            SingleExtraButtonsRowView(theme: theme, buttons: ButtonStorage.extraRowButtonsWithDataShort)
            SingleExtraButtonsRowView(theme: theme, buttons: ButtonStorage.extraRowButtonsWithDataShort)
        }
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
        .cornerRadius(20)
    }
    
    var portraitOrientedView: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(extraButtonsWithDataShort, id: \.self) { buttonData in
                CalculatorButton(buttonData: buttonData, theme: theme, cornerRadius: 18, isSelected: MathManager.instance.isSelected(buttonData)) {
                    MathManager.instance.receiveButtonTap(buttonData)
                }
                .frame(width: singleButtonWidth)
                .frame(height: singleButtonHeight)
            }
        }
    }
    
    func updateButtonDimensions(using verticalSize: UserInterfaceSizeClass?) {
        if verticalSize == .regular {
            singleButtonWidth = screenWidth / ButtonLayoutValues.PortraitVerticalSpaceToButtonWidthRatio
            singleButtonHeight = screenWidth / ButtonLayoutValues.PortraitVerticalSpaceToButtonHeightRatio / 1.8
            
            verticalSpacing = screenWidth / ButtonLayoutValues.VerticalSpaceToVerticalSpacingRatio
            horizontalSpacing = screenWidth / ButtonLayoutValues.VerticalSpaceToHorizontalSpacingRatio
        }
        
        else {
            singleButtonWidth = screenHeight / ButtonLayoutValues.LandscapeVerticalSpaceToButtonWidthRatio
            singleButtonHeight = singleButtonWidth / 1.8
            
            verticalSpacing = screenHeight / ButtonLayoutValues.VerticalSpaceToVerticalSpacingRatio
            horizontalSpacing = screenHeight / ButtonLayoutValues.VerticalSpaceToHorizontalSpacingRatio
        }
    }
    
    func updateScreenDimensions(using verticalSizeValue: UserInterfaceSizeClass?) {
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
    }
}

struct ExtraButtonsGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExtraButtonsGrid(theme: .lightTheme)
                .background(Color.blue.opacity(0.2))
            StandardButtonsGrid(theme: .lightTheme)
                .background(Color.blue.opacity(0.2))
        }
    }
}
