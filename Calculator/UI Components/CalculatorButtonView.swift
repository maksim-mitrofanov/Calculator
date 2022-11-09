//
//  CalculatorButtonView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 02.11.2022.
//

import SwiftUI

struct CalculatorButtonView: View {
    let buttonData: CalculatorButtonData
    let theme: CalculatorTheme
    let cornerRadius: CGFloat
    
    var isSelected: Bool = false
    let action: () -> Void
    
    private let standardButtonsWithData = ButtonStorage.standardButtonsWithData
    private let extraButtons = ButtonStorage.extraRowButtonsWithData
    
    var body: some View {
        Button {
            action()
            HapticsManager.instance.triggerNotification(for: buttonData)
            SoundManager.instance.playButtonTapSound()
            
        } label: {
            CalculatorButtonLabel(buttonData: buttonData, theme: theme, isSelected: isSelected, cornerRadius: cornerRadius)
        }
        .buttonStyle(
            AdaptiveButtonStyle(
                type: buttonData.layoutViewType == .number ? .coloured : .regular,
                cornerRadius: cornerRadius,
                isButtonStatePersisted:
                    buttonData.operationType == .mathOperation ? true : false)
        )
        
        .opacity(getButtonOpacity())
        .accessibilityIdentifier(buttonData.text)
    }
    
    func getButtonOpacity() -> CGFloat {
        if buttonData.text == "" && buttonData.imageName == "" { return 0 }
        else { return 1 }
    }
}
