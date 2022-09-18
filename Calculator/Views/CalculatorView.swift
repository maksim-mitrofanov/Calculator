//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    @State var isExpanded: Bool = false
    @State var themeOption: ThemeOption = .auto
    
    @Environment(\.colorScheme) var colorScheme
    
    enum ThemeOption {
        case auto, alwaysDark, alwaysLight
    }
    
    
    var body: some View {
        ZStack {
            
            //Background
            Rectangle()
                .foregroundColor(getCurrentTheme().backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 0) {
                additionalButtons
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Spacer()
                    CurrentNumberView(text: "123", theme: getCurrentTheme())
                }
                .padding()
                                
                GridTestView(theme: getCurrentTheme(), isExpanded: isExpanded)
                    .padding()
            }
        }
    }
    
    
    var backgroundRectangle: some View {
        RoundedRectangle(cornerRadius: 45)
            .foregroundColor(getCurrentTheme().backgroundColor)
            .shadow(color: getShadowColor(), radius: 25)
            .offset(y: getBackgroundOffset())
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            AdditionalButtonLabel(imageName: expansionButtonName, theme: getCurrentTheme())
        }
    }
    
    var switchToLightModeButton: some View {
        Button {
            withAnimation {
                themeOption = .alwaysLight
            }
        } label: {
            AdditionalButtonLabel(imageName: "sun.max", theme: getCurrentTheme())
                .scaleEffect(themeOption == .alwaysLight ? 0.8 : 1)
        }
    }
    
    var switchToDarkModeButton: some View {
        Button {
            withAnimation {
                themeOption = .alwaysDark
            }
        } label: {
            AdditionalButtonLabel(imageName: "moon", theme: getCurrentTheme())
                .scaleEffect(themeOption == .alwaysDark ? 0.8 : 1)
        }
    }
    
    var switchToAutoDarkModeButton: some View {
        Button {
            withAnimation {
                themeOption = .auto
            }
        } label: {
            AdditionalButtonLabel(imageName: "clock", theme: getCurrentTheme())
                .scaleEffect(themeOption == .auto ? 0.8 : 1)
        }
    }
    
    var additionalButtons: some View {
        HStack {
            expansionButton
            
            Spacer()
            switchToAutoDarkModeButton
            switchToLightModeButton
            switchToDarkModeButton
        }
    }
    
    private let expandImageName = "arrow.up.left.and.arrow.down.right"
    
    private let collapseImageName = "arrow.down.right.and.arrow.up.left"
    
    var expansionButtonName: String {
        isExpanded ? collapseImageName : expandImageName
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
    
    private func getBackgroundOffset() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if isExpanded { return screenHeight * 0.1 }
        else { return screenHeight * 0.2 }
    }
    
    private func getShadowColor() -> Color {
        let theme = getCurrentTheme()
        switch theme {
        case .lightTheme: return .black.opacity(0.25)
        case .darkTheme: return .white.opacity(0.25)
        default:
            return .black
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
