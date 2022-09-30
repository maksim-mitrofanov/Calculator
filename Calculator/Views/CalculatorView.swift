//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    @State private var isExtraButtonsRowExpanded: Bool = false
    @State private var isBackgroundExpanded: Bool = true
    @State private var themeOption: ThemeOption = .auto

    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        ZStack {
            backgroundColorFill
            TopBarButtons(isExtraButtonsRowExpanded: $isExtraButtonsRowExpanded, themeOption: $themeOption, theme: getCurrentTheme())
            ExpandableBackgroundView(theme: getCurrentTheme(), areButtonsExpanded: isExtraButtonsRowExpanded)
        }
    }
    
    var backgroundColorFill: some View {
        Rectangle()
            .foregroundColor(getCurrentTheme().backgroundColor)
            .edgesIgnoringSafeArea(.all)
    }
        
    
    
    
    
    
    //MARK: - Functions
    private func getCurrentThemeFromEnvironment() -> CalculatorTheme {
        if colorScheme == .light {
            return .lightTheme
        } else  {
            return .darkTheme
        }
    }
    
    private func getCurrentTheme() -> CalculatorTheme {
        switch themeOption {
        case .auto:
            return getCurrentThemeFromEnvironment()
        case .alwaysDark:
            return .darkTheme
        case .alwaysLight:
            return .lightTheme
        }
    }
}

struct AdditionalButtonLabel: View {
    let imageName: String
    let theme: CalculatorTheme
    
    var body: some View {
        Image(systemName: imageName)
            .padding(12)
            .font(.headline)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(theme.operationButtonColor))
            .foregroundColor(.black)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

struct CalcViewDefVals {
    static let cornerRadius: CGFloat = 42
    static let shadowRadius: CGFloat = 25
    
    static let screenHeight = UIScreen.main.bounds.height
    static let minTopOffset = screenHeight / 40
    static let maxTopOffset = screenHeight / 10
    static let extraOffset: CGFloat = 20
}
