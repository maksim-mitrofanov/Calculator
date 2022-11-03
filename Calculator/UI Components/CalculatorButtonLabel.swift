//
//  CalculatorButtonLabel.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 02.11.2022.
//

import SwiftUI

struct CalculatorButtonLabel: View {
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
