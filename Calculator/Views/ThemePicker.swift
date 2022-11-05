//
//  ThemePicker.swift
//  Calculator
//
//  Created by Максим Митрофанов on 04.10.2022.
//

import SwiftUI

struct ThemePicker: View {
    @State var currentThemeOption: PickerThemeOption = .followSystem
    @Binding var currentTheme: CalculatorTheme
    
    @Environment(\.colorScheme) var colorScheme

    
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
            .onAppear { updateCurrentThemeFromSystem(colorScheme) }
            .onChange(of: colorScheme, perform: updateCurrentThemeFromSystem(_:))
            .onChange(of: currentThemeOption, perform: updateCurrentThemeFromThemeOption(_:))
        }
    }
    
    private func updateCurrentThemeFromSystem(_ colorScheme: ColorScheme) -> Void {
        withAnimation {
            if currentThemeOption == .followSystem {
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
            case .alwaysDark:
                currentTheme = .darkTheme
            case .followSystem:
                updateCurrentThemeFromSystem(colorScheme)
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
