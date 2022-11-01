//
//  AlternativeButtonGrid.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 26.10.2022.
//

import SwiftUI

struct AlternativeButtonGrid: View {
    let buttons = ButtonStorage.mainButtonsWithData.flatMap { $0 }
    let zeroButtonData = ButtonStorage.zeroButton
    
    @State private var buttonWidth: CGFloat = 0
    @State private var buttonHeight: CGFloat = 0
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?

    
    var buttonColumnsData: [GridItem] {
        return [
            GridItem(.fixed(buttonWidth)),
            GridItem(.fixed(buttonWidth)),
            GridItem(.fixed(buttonWidth)),
            GridItem(.fixed(buttonWidth))
        ]
    }

    
    var body: some View {
        LazyVGrid(columns: buttonColumnsData) {
            ForEach(buttons, id: \.self) { buttonData in
                StandardCalculatorButton(buttonData: buttonData, theme: .lightTheme, cornerRadius: 26, action: { })
                    .frame(height: buttonHeight)
            }
        }
        .onChange(of: verticalSize) { newValue in
            screenWidth = UIScreen.main.bounds.width
            screenHeight = UIScreen.main.bounds.height
            
            updateButtonDimensions(using: newValue)
        }
        
        .onAppear {
            updateButtonDimensions(using: verticalSize)
        }
    }
        
    func updateButtonDimensions(using verticalSizeValue: UserInterfaceSizeClass?) {
        if verticalSizeValue == .regular {
            buttonWidth = screenWidth / 5
            buttonHeight = screenWidth / 5
        }
        
        else {
            buttonWidth = screenHeight / 6
            buttonHeight = screenHeight / 6
        }
    }
}

struct AlternativeButtonGrid_Previews: PreviewProvider {
    static var previews: some View {
        AlternativeButtonGrid()
    }
}
