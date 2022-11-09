//
//  TopBarButtons.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 02.11.2022.
//

import SwiftUI

struct TopBarButtons: View {
    @Binding var isExtraButtonsRowExpanded: Bool
    @Binding var isHistorySheetPresented: Bool
    @Binding var currentTheme: CalculatorTheme
    
    var body: some View {
        HStack {
            ThemePicker(currentTheme: $currentTheme)
                .frame(width: 120, height: 45)
                .background(currentTheme.data.numberButtonColor.opacity(0.8))
                .cornerRadius(12)
                .padding(.leading)
            
            Spacer()
            
            //Have solidColor background
            HStack {
                expansionButton

                showAllHistoryButton
            }
        }
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraButtonsRowExpanded.toggle()
            }
        } label: {
            Image(systemName: expansionButtonImageName)
                .foregroundColor(currentTheme.data.numbersTextColor)
                .padding()
                .background(currentTheme.data.numberButtonColor.opacity(0.8))
                .cornerRadius(15)
        }
    }
    
    var showAllHistoryButton: some View {
        Button {
            withAnimation {
                isHistorySheetPresented = true
            }
        } label: {
            Image(systemName: showHistoryImageName)
                .foregroundColor(currentTheme.data.numbersTextColor)
                .padding()
                .background(currentTheme.data.numberButtonColor.opacity(0.8))
                .cornerRadius(15)

        }
    }
    
    private let showHistoryImageName = "clock.arrow.circlepath"
    private let expandImageName = "arrow.up.left.and.arrow.down.right"
    private let collapseImageName = "arrow.down.right.and.arrow.up.left"
    
    var expansionButtonImageName: String {
        isExtraButtonsRowExpanded ? collapseImageName : expandImageName
    }
}

struct TopBarButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopBarButtons(isExtraButtonsRowExpanded: .constant(false), isHistorySheetPresented: .constant(false), currentTheme: .constant(.lightTheme))
    }
}
