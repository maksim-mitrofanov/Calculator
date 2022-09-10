//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var buttonStorage = ButtonStorage()
    @State var currentTheme = CalculatorTheme.lightTheme
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(currentTheme.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    expansionButton
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    CurrentNumberView(theme: currentTheme, text: "123412aouoasnthusnthsnthsth41234")
                }
                .padding()
                
                ButtonsGridView(buttons: buttonStorage.buttonsWithData, theme: currentTheme)
            }
            .padding(.horizontal)

        }
        .onChange(of: colorScheme) { newValue in
            if newValue == .light { currentTheme = .lightTheme }
            else { currentTheme = .darkTheme }
        }
    }
    
    var expansionButton: some View {
        Button {
            buttonStorage.isExpanded.toggle()
        } label: {
            ExpansionButtonLabel(imageName: buttonStorage.expansionButtonName, theme: currentTheme)
        }
    }
    
    struct ExpansionButtonLabel: View {
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
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(currentTheme: .darkTheme)
        CalculatorView(currentTheme: .lightTheme)
    }
}
