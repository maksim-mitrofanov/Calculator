//
//  TopBarButtons.swift
//  Calculator
//
//  Created by Максим Митрофанов on 27.09.2022.
//

import SwiftUI

struct TopBarButtons: View {
    @Binding var isHistorySheetPresented: Bool
    @Binding var isExtraButtonsRowExpanded: Bool
    @Binding var theme: CalculatorTheme
    
    var body: some View {
        VStack {
            HStack {
                ThemePicker(currentTheme: $theme)
                Spacer()
                extraButtons
            }
            Spacer()
        }
        .padding()
        .padding(.top)
    }
    
    var extraButtons: some View {
        HStack {
            expansionButton
                .padding(.horizontal)
            Divider().frame(maxHeight: 25)
            showAllHistoryButton
                .padding(.horizontal)
        }
        .foregroundColor(.black)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 18).foregroundColor(theme.data.operationButtonColor)
                .opacity(theme == .lightTheme ? 0.8 : 1)
        )
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraButtonsRowExpanded.toggle()
            }
        } label: {
            Image(systemName: expansionButtonName)
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
    
    var expansionButtonName: String {
        isExtraButtonsRowExpanded ? collapseImageName : expandImageName
    }
}

struct AdditionalButtonLabel: View {
    let imageName: String
    let theme: CalculatorThemeData
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(.black)
            .padding(12)
            .font(.title3)
            .background(
                RoundedRectangle(cornerRadius: 17)
                    .foregroundColor(theme.operationButtonColor)
                )
            .foregroundColor(.black)
    }
}
