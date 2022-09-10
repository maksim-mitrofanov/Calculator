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
            
            GeometryReader { geometry in
                VStack {
                    expansionButton
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        CurrentNumberView(text: "123", theme: currentTheme)
                    }
                    .padding(.horizontal)
                    
                    ButtonsGridView(buttonStorage: buttonStorage, theme: currentTheme, geometryProxy: geometry)
                }
            }
        }
        .onChange(of: colorScheme) { newValue in
            if newValue == .light { currentTheme = .lightTheme }
            else { currentTheme = .darkTheme }
        }
    }
    
    var expansionButton: some View {
        HStack {
            Button {
                withAnimation {
                    buttonStorage.isExpanded.toggle()
                }
            } label: {
                ExpansionButtonLabel(imageName: buttonStorage.expansionButtonName, theme: currentTheme)
            }
            Spacer()
        }
    }
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(currentTheme: .lightTheme)
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

struct CurrentNumberView: View {
    let text: String
    let theme: CalculatorTheme
    
    var body: some View {
        Text(text)
            .font(Font.system(size: 55))
            .lineLimit(2)
            .minimumScaleFactor(0.6)
            .foregroundColor(theme.numbersTextColor)
    }
}
