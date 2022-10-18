//
//  AdaptiveButtonStyleViewTest.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 18.10.2022.
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
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.6 : 1)
            .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(colors.randomElement() ?? Color.black)
                        .opacity(configuration.isPressed ? 1 : 0)
            )
    }
}

struct AdaptiveButtonStyleViewTest: View {
    var body: some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .aspectRatio(1/1, contentMode: .fit)
                .foregroundStyle(.thickMaterial)
                .overlay(
                    Text("5").font(.title)
                )
                .foregroundColor(.black)
                .frame(width: 75, height: 75)
        }
        .buttonStyle(AdaptiveButtonStyle())
    }
}

struct AdaptiveButtonStyleViewTest_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveButtonStyleViewTest()
    }
}
