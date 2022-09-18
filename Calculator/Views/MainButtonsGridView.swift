//
//  MainButtonsGridView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

struct ButtonLayout {
    static let screenWidth = UIScreen.main.bounds.width
    static let buttonToScreenRatio: CGFloat = 5
    static let verticalSpacing: CGFloat = 4
    static let horizontalSpacing: CGFloat = 5
    static let mainButtons = ButtonStorage.mainButtonsWithData
    static let extraButtons = ButtonStorage.extraRowButtonsWithData
    
    static func buttonWidth(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.type == .extraOperation {
            return screenWidth / buttonToScreenRatio
        } else {
            switch buttonData.aspectRatio {
            case 1/2: return screenWidth / (buttonToScreenRatio / 2) + horizontalSpacing * 2
            default: return screenWidth / buttonToScreenRatio
            }
        }
    }
    
    static func buttonHeight(for buttonData: CalculatorButtonData) -> CGFloat {
        if buttonData.type == .extraOperation {
            return screenWidth / buttonToScreenRatio / 2
        } else {
            switch buttonData.aspectRatio {
            case 2/1: return screenWidth / (buttonToScreenRatio / 2) + horizontalSpacing * 2
            default: return screenWidth / buttonToScreenRatio
            }
        }
    }
}

struct MainButtonsGridView: View {
    let theme: CalculatorTheme

    private let buttons = ButtonStorage.mainButtonsWithData
    private let screenWidth = ButtonLayout.screenWidth
    private let buttonToScreenRatio = ButtonLayout.buttonToScreenRatio
    
    var body: some View {
        VStack {
            mainButtonsGrid
                .frame(maxWidth: totalWidth())
//                .background {
//                    Rectangle()
//                        .stroke()
//                }
        }
    }
    
    var mainButtonsGrid: some View {
        WrappingHStack(models: buttons, horizontalSpacing: ButtonLayout.horizontalSpacing, verticalSpacing: ButtonLayout.verticalSpacing) { buttonData in
            Button {
                
            } label: {
                CalculatorButtonLabel(buttonData: buttonData, theme: theme)
                    .foregroundColor(.black)
                    .frame(width: ButtonLayout.buttonWidth(for: buttonData))
                    .frame(height: ButtonLayout.buttonHeight(for: buttonData))
            }
        }
    }
    
    func totalWidth() -> CGFloat {
        return (screenWidth / buttonToScreenRatio) * 4 + (ButtonLayout.horizontalSpacing * 8)
    }
}


struct MainButtonsGridView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        MainButtonsGridView(theme: .lightTheme)
    }
}
