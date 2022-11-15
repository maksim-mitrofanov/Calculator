//
//  SettingsView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 13.11.2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var currentTheme: CalculatorTheme
    
    
    var body: some View {
        VStack {
            //Title
            HStack {
                Text("Settings")
                    .foregroundColor(currentTheme.data.numbersTextColor)
                    .font(.largeTitle.bold())
                    .scaleEffect(1.2)
                Spacer()
            }
            .padding()
            
            ScrollView {
                RoundedRectangle(cornerRadius: 20)
                    .fill(getRectangleGradient())
                    .aspectRatio(3/1, contentMode: .fit)
                
                    .overlay {
                        RoundedRectangle(cornerRadius: 18)
                            .foregroundColor(currentTheme.data.backgroundColor)
                            .padding(3)
                    }
                
                    .overlay {
                        HStack {
                            Text("Theme Option: ")
                                .foregroundColor(currentTheme.data.numbersTextColor)
                                .font(.title2).bold()
                            ThemePicker(currentTheme: $currentTheme)
                        }
                        .padding()
                    }
                
                
            }
            Spacer()
        }
        .padding()
        
    }
    
    private func getRectangleGradient() -> LinearGradient {
        LinearGradient(
            colors: [currentTheme.data.equalsButtonColor, currentTheme.data.equalsButtonColor],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(tab: .settings)
    }
}
