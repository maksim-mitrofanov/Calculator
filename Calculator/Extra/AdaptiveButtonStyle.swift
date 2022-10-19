//
//  AdaptiveButtonStyle.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import SwiftUI

struct AdaptiveButtonStyle: ButtonStyle {
    let colors: [Color] = [
        Color.blue,
        Color.brown,
        Color.cyan,
        Color.green,
        Color.indigo,
        Color.mint,
        Color.orange,
        Color.pink,
        Color.purple,
        Color.red,
        Color.teal,
        Color.yellow
    ]
    
    var cornerRadius: CGFloat = 20
    var isButtonStatePersisted: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        if isButtonStatePersisted == false {
            configuration.label
                .opacity(configuration.isPressed ? 0.6 : 1)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(colors.randomElement() ?? Color.black)
                        .opacity(configuration.isPressed ? 1 : 0)
                )
        } else {
            configuration.label
        }
    }
}
