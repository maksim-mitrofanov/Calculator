//
//  ThemeStorage.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI
import Foundation

class CalculatorThemeStorage: ObservableObject {
    static let lightTheme = CalculatorTheme(
        numberButtonColor: Color(red: 236, green: 236, blue: 236),
        operationButtonColor: Color(red: 213, green: 213, blue: 213),
        equalsButtonColor: Color(red: 255, green: 203, blue: 130),
        
        numbersTextColor: Color.black,
        operationTextColor: Color.black,
        equalsTextColor: Color.black,
        
        backgroundColor: Color.white
    )

    static let darkTheme = CalculatorTheme(
        numberButtonColor: Color(red: 50, green: 50, blue: 50),
        operationButtonColor: Color(red: 118, green: 118, blue: 118),
        equalsButtonColor: Color(red: 197, green: 128, blue: 48),
        
        numbersTextColor: Color.white,
        operationTextColor: Color.black,
        equalsTextColor: Color.black,
        
        backgroundColor: Color(red: 35, green: 35, blue: 35)
    )
    
    @Published var currentTheme = lightTheme
    
    func toggleTheme() {
        if currentTheme == CalculatorThemeStorage.lightTheme {
            currentTheme = CalculatorThemeStorage.darkTheme
        } else {
            currentTheme = CalculatorThemeStorage.lightTheme
        }
        
    }
}
