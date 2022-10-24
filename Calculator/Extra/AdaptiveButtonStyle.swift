//
//  AdaptiveButtonStyle.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import SwiftUI

struct AdaptiveButtonStyle: ButtonStyle {
    enum ButtonType { case coloured, regular }
    
    private let colors: [Color] = [
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
    
    var type: ButtonType
    var cornerRadius: CGFloat
    var isButtonStatePersisted: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(getOpacity(from: configuration))
            .overlay { getOverlay(from: configuration) }
    }
    
    func getOpacity(from configuration: Configuration) -> CGFloat {
        if isButtonStatePersisted { return 1 }
        else { return configuration.isPressed ? 0.6 : 1}
    }
    
    func getOverlay(from configuration: Configuration) -> some View {
        VStack {
            if type == .coloured {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(colors.randomElement() ?? Color.black)
                    .opacity(configuration.isPressed ? 1 : 0)
            }
        }
    }
}
