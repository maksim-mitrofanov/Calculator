//
//  ThemePicker.swift
//  Calculator
//
//  Created by Максим Митрофанов on 04.10.2022.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var currentTheme: CalculatorTheme
    
    //Used by Picker
    @State private var currentThemeOption: PickerThemeOption = .followSystem
    
    //Used to store currentThemeOption
    @AppStorage("isFollowingSystem") private var isFollowingSystem = false
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("isLightModeOn") private var isLightModeOn = false
    
    
    @Environment(\.colorScheme) var deviceColorScheme
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    

    
    var body: some View {
        VStack {
            //.animation() removed from currentThemeOption
            Picker(selection: $currentThemeOption) {
                ForEach(PickerThemeOption.allCases, id: \.self) { option in
                    Label(" \(option.description) ", systemImage: themeOptionToImageName[option] ?? "bug")
                }
            } label: {
                Text("Theme Opiton")
            }
            .accentColor(currentTheme.data.numbersTextColor)
            .pickerStyle(.menu)
            
            
            //Updates current theme to device colour scheme
            .onChange(of: deviceColorScheme, perform: updateCurrentThemeFromSystem(_:))
            
            //Updates user defaults according to current theme option
            .onChange(of: currentThemeOption, perform: updateCurrentThemeFromThemeOption(_:))
            
            
            //Updates current view according to user defaults
            .onAppear {
                updateCurrentThemeFromSystem(deviceColorScheme)
                updateCurrentThemeAndThemeOptionFromUserDefaults()
            }
        }
    }
    
    private func updateUserDefaultsAndCurrentTheme(with themeOption: ThemeOption) {
        switch themeOption {
        case .auto:
            isFollowingSystem = true
            isDarkModeOn = false
            isLightModeOn = false
            
        case .alwaysDark:
            isFollowingSystem = false
            isDarkModeOn = true
            isLightModeOn = false
            
        case .alwaysLight:
            isFollowingSystem = false
            isDarkModeOn = false
            isLightModeOn = true
        }
    }
    
    private func updateCurrentThemeAndThemeOptionFromUserDefaults() {
        if isDarkModeOn {
            currentTheme = .darkTheme
            currentThemeOption = .alwaysDark
        }
        
        else if isLightModeOn {
            currentTheme = .lightTheme
            currentThemeOption = .alwaysLight
        }
        
        else {
            currentThemeOption = .followSystem
        }
    }
    
    private func updateCurrentThemeFromSystem(_ colorScheme: ColorScheme) -> Void {
        withAnimation {
            if isFollowingSystem {
                if colorScheme == .light { currentTheme = .lightTheme }
                else if colorScheme == .dark { currentTheme = .darkTheme }
            }
        }
    }
    
    private func updateCurrentThemeFromThemeOption(_ themeOption: ThemePicker.PickerThemeOption) -> Void {
        withAnimation {
            switch themeOption {
            case .alwaysLight:
                currentTheme = .lightTheme
                
                isFollowingSystem = false
                isDarkModeOn = false
                isLightModeOn = true
                                
            case .alwaysDark:
                currentTheme = .darkTheme
                
                isFollowingSystem = false
                isDarkModeOn = true
                isLightModeOn = false
                
            case .followSystem:
                updateCurrentThemeFromSystem(deviceColorScheme)
                
                isFollowingSystem = true
                isDarkModeOn = false
                isLightModeOn = false
            }
        }
    }
    
    public enum PickerThemeOption: String, CaseIterable {
        case alwaysLight
        case alwaysDark
        case followSystem
        
        var description: String {
            switch self {
            case .alwaysLight: return "Light"
            case .alwaysDark: return "Dark"
            case .followSystem: return "System"
            }
        }
    }
    
    private let themeOptionToImageName: [PickerThemeOption : String] = [.alwaysLight : "sun.max", .alwaysDark : "moon.stars", .followSystem : "clock"]
}


struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
