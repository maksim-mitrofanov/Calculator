//
//  AdaptiveButtonStyleViewTest.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 18.10.2022.
//

import SwiftUI

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
