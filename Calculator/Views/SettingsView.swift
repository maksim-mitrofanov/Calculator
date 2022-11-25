//
//  SettingsView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 13.11.2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var currentTheme: CalculatorTheme
    @Binding var currentThemeOption: ThemeOption
    @Binding private var currentColorScheme: ColorScheme?
    
    //Used to change values in UserDefaults
    @AppStorage("isFollowingSystem") private var isFollowingSystem = false
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("isLightModeOn") private var isLightModeOn = false
    
    
    //Theme
    @Environment(\.colorScheme) var deviceColorScheme
    
    //Shake to clear current number
    @AppStorage("isShakeToClearOn") private var isShakeToClearOn: Bool = false
    
    
    init(currentTheme: Binding<CalculatorTheme>, currentThemeOption: Binding<ThemeOption>, currentColorScheme: Binding<ColorScheme?>) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray.withAlphaComponent(0.8)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.quaternaryLabel
        
        self._currentTheme = currentTheme
        self._currentThemeOption = currentThemeOption
        self._currentColorScheme = currentColorScheme
    }
    
    
    
    var body: some View {
        VStack {
            //Title
            HStack {
                header
                Spacer()
            }
            .padding()
            .padding()
            
            //Settings
            ScrollView {
                shakeToDeleteToggle
                themeOptionPicker
            }
            Spacer()
        }
        .preferredColorScheme(currentColorScheme)
        
        .onAppear() { updatePreferredColorScheme() }
        
        //Updates UserDefaults and PreferredColorScheme
        .onChange(of: currentThemeOption, perform: updateUserDefaults(with:))
    }
    
    var header: some View {
        Text("Settings")
            .foregroundColor(currentTheme.data.numbersTextColor)
            .font(.largeTitle.bold())
            .scaleEffect(1.2)
    }
    
    var themeOptionPicker: some View {
        VStack {
            TabView(selection: $currentThemeOption) {
                ForEach(ThemeOption.allCases, id: \.self) { themeOption in
                    ThemeOptionPreview(option: themeOption, theme: currentTheme)
                        .tag(themeOption)
                    
                        .padding(.vertical)
                        .padding(.bottom)
                }
                .padding(.bottom)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 300)
        }
    }
    
    var shakeToDeleteToggle: some View {
        HStack {
            Text("Shake to clear current number:")
            Spacer()
            Toggle("", isOn: $isShakeToClearOn)
                .frame(width: 50)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
        }
        .padding()
    }
    
    private func updatePreferredColorScheme() {
        withAnimation {
            if currentThemeOption == .alwaysLight { currentColorScheme = .light }
            else if currentThemeOption == .alwaysDark { currentColorScheme = .dark }
            else { currentColorScheme = .none }
        }
    }
    
    private func updateUserDefaults(with themeOption: ThemeOption) -> Void {
        withAnimation {
            switch themeOption {
            case .alwaysLight:
                isFollowingSystem = false
                isDarkModeOn = false
                isLightModeOn = true
                
                currentTheme = .lightTheme
                currentColorScheme = .light
                
            case .alwaysDark:
                
                isFollowingSystem = false
                isDarkModeOn = true
                isLightModeOn = false
                
                currentTheme = .darkTheme
                currentColorScheme = .dark
                
                
            case .auto:
                
                isFollowingSystem = true
                isDarkModeOn = false
                isLightModeOn = false
                
                
                if deviceColorScheme == .light { currentTheme = .lightTheme }
                else { currentTheme = .darkTheme }
                currentColorScheme = .none
            }
        }
    }
    
    struct ThemeOptionPreview: View {
        let option: ThemeOption
        let theme: CalculatorTheme
        
        var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
//                .shadow(color: theme.data.numbersTextColor.opacity(0.1), radius: 7, x: 2, y: 2)
                .aspectRatio(3/2, contentMode: .fit)
            
                .overlay {
                    VStack {
                        Image(systemName: getImageName(for: option))
                            .font(.largeTitle)
                            .scaleEffect(1.2)
                            .padding(.bottom)
                            .foregroundColor(theme.data.numbersTextColor)
                        
                        Text(getName(for: option))
                            .font(.title3)
                            .bold()
                            .foregroundColor(theme.data.numbersTextColor)
                        
                        Text(getDescription(for: option))
                            .font(.subheadline)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                            .foregroundColor(Color.gray)
                    }
                }
        }
        
        private func getImageName(for selectedOption: ThemeOption) -> String {
            switch selectedOption {
            case .auto:
                return "clock"
            case .alwaysDark:
                return "moon.stars"
            case .alwaysLight:
                return "sun.max"
            }
        }
        
        private func getName(for selectedOption: ThemeOption) -> String {
            switch selectedOption {
            case .auto:
                return "Follow System"
            case .alwaysDark:
                return "Always Dark Theme"
            case .alwaysLight:
                return "Always Light Theme"
            }
        }
        
        private func getDescription(for selectedOption: ThemeOption) -> String {
            switch selectedOption {
            case .auto:
                return "App theme follows your device theme"
            case .alwaysDark:
                return "App theme is always dark"
            case .alwaysLight:
                return "App theme is always light"
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(tab: .settings)
    }
}
