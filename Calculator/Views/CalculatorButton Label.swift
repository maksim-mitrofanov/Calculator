//
//  CalculatorButtonLabel.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 03.09.2022.
//

import SwiftUI

struct CalculatorButtonLabel: View {
    let buttonData: CalculatorButtonData
    let theme: CalculatorTheme
    
    private let cornerRadius: CGFloat = 26
    
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
                    .foregroundColor(theme.textColorFor(buttonType: buttonData.type))
                    .font(.title)
            }
    }
    
    var imageLabel: some View {
        backgroundView
            .overlay(
                Text(Image(systemName: buttonData.imageName))
                    .foregroundColor(theme.textColorFor(buttonType: buttonData.type))
                    .font(.title2)
            )
    }
    
    var backgroundView: some View {
        Rectangle()
            .foregroundColor(theme.buttonColorFor(buttonType: buttonData.type))
    }
}
