//
//  TestPickerOverflow.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 05.11.2022.
//

import SwiftUI

struct TestPickerOverflow: View {
    @State private var currentTheme: CalculatorTheme = .lightTheme
    
    var body: some View {
//        VStack {
//            Picker(selection: $currentThemeOption.animation()) {
//                ForEach(PickerThemeOption.allCases, id: \.self) { option in
//                    Label(" \(option.description) ", systemImage: themeOptionToImageName[option] ?? "bug")
//                }
//            } label: {
//                Text("Theme Opiton")
//            }
//            .accentColor(currentTheme.data.numbersTextColor)
//            .pickerStyle(.menu)
//            .onAppear { updateCurrentThemeFromSystem(colorScheme) }
//            .onChange(of: colorScheme, perform: updateCurrentThemeFromSystem(_:))
//            .onChange(of: currentThemeOption, perform: updateCurrentThemeFromThemeOption(_:))
//        }
        ThemePicker(currentTheme: $currentTheme)
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

struct TestPickerOverflow_Previews: PreviewProvider {
    static var previews: some View {
        TestPickerOverflow()
    }
}
