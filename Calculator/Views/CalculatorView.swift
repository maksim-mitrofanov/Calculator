//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View  {
    //Sets theme
    @AppStorage("isFollowingSystem") private var isFollowingSystem = false
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("isLightModeOn") private var isLightModeOn = false
    
    
    @State var selectedTab: CalculatorViewTab = .mainCalculator
    @State private var currentTheme: CalculatorTheme = .lightTheme
    @State private var isExtraRowExpanded: Bool = false
    
    @Environment(\.colorScheme) var currentColorScheme
    
    init(tab: CalculatorViewTab = .mainCalculator) {
        selectedTab = tab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            currentTheme.data.backgroundColor.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    expansionButton
                        .opacity(0.8)
                    Spacer()
                    CustomCalculatorTabView(selectedTab: $selectedTab)
                }
                .padding(.leading)


                TabView(selection: $selectedTab) {
                    switch selectedTab {
                    case .mainCalculator:
                        ZStack {
                            currentTheme.data.backgroundColor.edgesIgnoringSafeArea(.all)
                            StandardCalculatorView(isExpanded: isExtraRowExpanded, currentTheme: currentTheme)
                        }
                    case .history:
                        ZStack {
                            currentTheme.data.backgroundColor.edgesIgnoringSafeArea(.all)
                            HistorySheetView(theme: currentTheme)
                        }
                    case .settings:
                        ZStack {
                            currentTheme.data.backgroundColor.edgesIgnoringSafeArea(.all)
                            SettingsView(currentTheme: $currentTheme)
                        }
                    }
                }


            }
        }
        .onAppear() {
            updateCurrentThemeFromUserDefaults()
        }
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraRowExpanded.toggle()
            }
            
        } label: {
            Image(systemName: expansionButtonImageName)
                .font(.title2)
                .foregroundColor(currentTheme.data.numbersTextColor)
        }
    }
    
    var expansionButtonImageName: String {
        if isExtraRowExpanded { return "arrow.up.left.and.arrow.down.right" }
        else { return "arrow.down.right.and.arrow.up.left" }
    }
    
    private func updateCurrentThemeFromUserDefaults() {
        if isFollowingSystem {
            if currentColorScheme == .light { currentTheme = .lightTheme}
            else { currentTheme = .darkTheme }
        }
        
        else if isDarkModeOn { currentTheme = .darkTheme }
        else if isLightModeOn { currentTheme = .lightTheme }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
