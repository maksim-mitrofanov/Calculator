//
//  TabViewTest.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 13.10.2022.
//

import SwiftUI

struct TabViewTest: View {
    var body: some View {
        TabView {
            TabSingleView(imageName: "gearshape.2", mainText: "Engineering calculator", secondaryText: "With all buttons available")
            
            TabSingleView(imageName: "plus.forwardslash.minus", mainText: "standard calculator", secondaryText: "With extra buttons")
            
            TabSingleView(imageName: "camera.shutter.button", mainText: "Camera calculator", secondaryText: "Uses Apple API")
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct TabSingleView: View {
    var imageName: String
    var mainText: String
    var secondaryText: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .font(Font.system(size: 60))
                .padding(.bottom)
            
            Text(mainText)
                .font(.title2)
            
            Text(secondaryText)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct TabViewTest_Previews: PreviewProvider {
    static var previews: some View {
        TabViewTest()
    }
}
