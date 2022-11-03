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
            Spacer()
            
            //Have solidColor background
            HStack {
                expansionButton.padding(.horizontal)
                Divider().frame(maxHeight: 25)
                showAllHistoryButton.padding(.horizontal)
            }
            .foregroundColor(.black)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 18).foregroundColor(currentTheme.data.operationButtonColor)
                    .opacity(currentTheme == .lightTheme ? 0.8 : 1)
            )
        }
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraButtonsRowExpanded.toggle()
            }
        } label: {
            Image(systemName: expansionButtonImageName)
        }
    }
    
    var showAllHistoryButton: some View {
        Button {
            withAnimation {
                isHistorySheetPresented = true
            }
        } label: {
            Image(systemName: showHistoryImageName)
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
