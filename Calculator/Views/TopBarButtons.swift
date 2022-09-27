//
//  TopBarButtons.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct TopBarButtons: View {
    @Binding var isExtraButtonsRowExpanded: Bool
    @Binding var themeOption: ThemeOption
    let theme: CalculatorTheme
    
    var body: some View {
        VStack {
            HStack {
                switchToAutoDarkModeButton
                switchToLightModeButton
                switchToDarkModeButton
                Spacer()
                expansionButton
            }
            Spacer()
        }
        .padding()
        .padding(.top)
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraButtonsRowExpanded.toggle()
            }
        } label: {
            AdditionalButtonLabel(imageName: expansionButtonName, theme: theme)
        }
    }
    
    var switchToLightModeButton: some View {
        Button {
            withAnimation {
                themeOption = .alwaysLight
            }
        } label: {
            AdditionalButtonLabel(imageName: "sun.max", theme: theme)
                .scaleEffect(themeOption == .alwaysLight ? 0.8 : 1)
        }
    }
    
    var switchToDarkModeButton: some View {
        Button {
            withAnimation {
                themeOption = .alwaysDark
            }
        } label: {
            AdditionalButtonLabel(imageName: "moon", theme: theme)
                .scaleEffect(themeOption == .alwaysDark ? 0.8 : 1)
        }
    }
    
    var switchToAutoDarkModeButton: some View {
        Button {
            withAnimation {
                themeOption = .auto
            }
        } label: {
            AdditionalButtonLabel(imageName: "clock", theme: theme)
                .scaleEffect(themeOption == .auto ? 0.8 : 1)
        }
    }
    
    private let expandImageName = "arrow.up.left.and.arrow.down.right"
    
    private let collapseImageName = "arrow.down.right.and.arrow.up.left"
    
    var expansionButtonName: String {
        isExtraButtonsRowExpanded ? collapseImageName : expandImageName
    }
}

