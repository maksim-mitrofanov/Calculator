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
    
    //Tab
    @State var selectedTab: CalculatorViewTab = .mainCalculator
    
    //Theme
    @State private var currentTheme: CalculatorTheme = .lightTheme
    @State private var currentThemeOption: ThemeOption = .auto
    @State private var currentColorScheme: ColorScheme? = .none
    
    @Environment(\.colorScheme) var deviceColorScheme
    
    
    //For main View
    @State private var isExtraRowExpanded: Bool = false
    
    
    init(tab: CalculatorViewTab = .mainCalculator) {
        selectedTab = tab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            backgroundFill
            
            VStack {
                topTabBarView
                tabs
            }
        }
        .preferredColorScheme(currentColorScheme)
        
        //Updates current themeOption according to user defaults
        .onAppear {
            updateCurrentThemeOptionFromUserDefaults()
        }
                
        //Update current theme according to device colorScheme
        .onChange(of: deviceColorScheme, perform: updateCurrentThemeUsing(deviceColorScheme:))
    }
    
    var backgroundFill: some View {
        currentTheme.data.backgroundColor.edgesIgnoringSafeArea(.all)
    }
    
    var topTabBarView: some View {
        HStack {
            if selectedTab == .mainCalculator {
                expansionButton
                    .transition(.scale)
                    .opacity(0.8)
                Spacer()
            }
            CustomCalculatorTabView(selectedTab: $selectedTab)
        }
        .padding(.leading)
    }
    
    var tabs: some View {
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
                    SettingsView(currentTheme: $currentTheme, currentThemeOption: $currentThemeOption, currentColorScheme: $currentColorScheme)
                }
            }
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
        if isExtraRowExpanded { return "arrow.down.right.and.arrow.up.left" }
        else { return "arrow.up.left.and.arrow.down.right" }
    }
    
    private func updateCurrentThemeOptionFromUserDefaults() {
        withAnimation {
            if isDarkModeOn {
                currentThemeOption = .alwaysDark
                currentTheme = .darkTheme
            }
            
            else if isLightModeOn {
                currentThemeOption = .alwaysLight
                currentTheme = .lightTheme
            }
            
            else {
                currentThemeOption = .auto
                
                if deviceColorScheme == .light { currentTheme = .lightTheme }
                else { currentTheme = .darkTheme }
            }
        }
    }
    
    private func updateCurrentThemeUsing(deviceColorScheme: ColorScheme) {
        if currentThemeOption == .auto {
            if deviceColorScheme == .light {
                currentTheme = .lightTheme
            }
            else {
                currentTheme = .darkTheme
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
