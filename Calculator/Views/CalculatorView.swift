//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var themeStorage = CalculatorThemeStorage()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(themeStorage.currentTheme.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button {
                    themeStorage.toggleTheme()
                } label: {
                    Text("Toggle Theme")
                }
                
                Spacer()
                
                ButtonsGridView(theme: themeStorage.currentTheme)
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
