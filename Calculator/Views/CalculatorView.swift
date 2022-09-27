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
    @State var themeOption: ThemeOption = .auto
    
    @Environment(\.colorScheme) var colorScheme
    
    private let screenHeight = UIScreen.main.bounds.height
    
    
    enum ThemeOption {
        case auto, alwaysDark, alwaysLight
    }
    
    
    var body: some View {
        ZStack {
            backgroundColorFill
            themeAndExpansionButtons
//            expandableBackground
            calculatorButtons
        }
    }
    
    var backgroundColorFill: some View {
        Rectangle()
            .foregroundColor(getCurrentTheme().backgroundColor)
            .edgesIgnoringSafeArea(.all)
    }
    
    var themeAndExpansionButtons: some View {
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
    }
    
    var expandableBackground: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 42)
                .foregroundColor(getCurrentTheme().backgroundColor)
                .shadow(color: getShadowColor(), radius: 25)
                .overlay(expandableBackgroundOverlay)
                .offset(y: expandableBackgroundHeightOffset)
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .gesture (
            DragGesture()
                .onChanged { gesture in dragGestureValueChanged(gesture.translation.height) }
                .onEnded { gesture in dragGestureEnded(gesture.translation.height) }
        )
    }
    
    func dragGestureValueChanged(_ gestureHeightValue: Double) {
        withAnimation(.linear) {
            if gestureHeightValue < 100 {
                expandableBackgroundHeightOffset = gestureHeightValue
                
            }
            print("Current offset: \(gestureHeightValue)")
        }
    }
    
    func dragGestureEnded(_ gestureHeightValue: Double) {
        print("Ended: \(gestureHeightValue)")

    }
     
    var calculatorButtons: some View {
        VStack {
            Spacer()
            
//            HStack {
//                Spacer()
//                CurrentNumberView(text: mathManager.currentNumber, theme: getCurrentTheme())
//            }
//            .padding(.horizontal)
//            .padding(.bottom)
//            .padding(.bottom, isBackgroundExpanded ? 20 : 0)
            
            if isExtraButtonsRowExpanded { ExtraButtonsGridView(mathManager: mathManager, theme: getCurrentTheme())}
            MainButtonsGridView(mathManager: mathManager,theme: getCurrentTheme())
        }
        .padding(.horizontal)
    }
    
    var expandableBackgroundOverlay: some View {
        VStack {
            HStack {
                Spacer()
                pullTab
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                CurrentCalculationHistory(text: mathManager.operationsHistory.joined(), theme: getCurrentTheme())
            }
            Spacer()
        }
        .padding()
        .padding()
    }
    
    private func getBackgroundOffset() -> CGFloat {
        if isBackgroundExpanded { return screenHeight / 150 }
        else { return screenHeight / 10 }
    }
    
    private func getShadowColor() -> Color {
        let theme = getCurrentTheme()
        switch theme {
        case .lightTheme: return .black.opacity(0.1)
        case .darkTheme: return .gray.opacity(0.1)
        default:
            return .black
        }
    }
    
    var pullTab: some View {
        Button {
            withAnimation {
                isBackgroundExpanded.toggle()
            }
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.gray.opacity(0.6))
                .aspectRatio(5/1, contentMode: .fit)
                .frame(height: 8)
        }
    }
        
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraButtonsRowExpanded.toggle()
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
    
    private let expandImageName = "arrow.up.left.and.arrow.down.right"
    
    private let collapseImageName = "arrow.down.right.and.arrow.up.left"
    
    var expansionButtonName: String {
        isExtraButtonsRowExpanded ? collapseImageName : expandImageName
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
