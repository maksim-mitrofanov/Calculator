//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var mathManager = MathManager()
    
    @State var isExtraButtonsRowExpanded: Bool = false
    @State var expandableBackgroundHeightOffset: CGFloat = .zero
    @State var isBackgroundExpanded: Bool = true
    @State var themeOption: CalcViewDefVals.ThemeOption = .auto

    @Environment(\.colorScheme) var colorScheme
        
    
    
    
    
    var body: some View {
        ZStack {
            backgroundColorFill
            TopBarButtons(isExtraButtonsRowExpanded: $isExtraButtonsRowExpanded, themeOption: $themeOption, theme: getCurrentTheme())
            ExpandableBackgroundView(theme: getCurrentTheme())
            CalculatorButtonsView(isExpanded: isExtraButtonsRowExpanded, theme: getCurrentTheme())
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

struct CurrentNumberView: View {
    let text: String
    let theme: CalculatorTheme
    
    var body: some View {
        Text(text)
            .font(Font.system(size: 55))
            .lineLimit(2)
            .minimumScaleFactor(0.6)
            .foregroundColor(theme.numbersTextColor)
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
    
    enum ThemeOption {
        case auto, alwaysDark, alwaysLight
    }
}
