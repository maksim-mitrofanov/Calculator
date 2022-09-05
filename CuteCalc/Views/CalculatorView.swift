//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    private var lightTheme = CalculatorThemeStorage().lightTheme
    private var darkTheme = CalculatorThemeStorage().darkTheme
    
    @State var currentTheme = CalculatorThemeStorage().lightTheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(currentTheme.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button {
                    toggleTheme()
                } label: {
                    Text("Toggle Theme")
                }
                
                Spacer()
                
                ButtonsGridView(theme: currentTheme)
            }
        }
    }
    
    func toggleTheme() {
        withAnimation {
            if currentTheme == lightTheme {
                currentTheme = darkTheme
            } else {
                currentTheme = lightTheme
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
