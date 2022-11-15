//
//  CustomCalculatorTabView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 13.11.2022.
//

import SwiftUI

enum CalculatorViewTab: String, CaseIterable {
    case mainCalculator
    case history
    case settings
}

struct CustomCalculatorTabView: View {
    @Binding var selectedTab: CalculatorViewTab
    
    var body: some View {
        HStack {
            ForEach(CalculatorViewTab.allCases, id: \.rawValue) { tab in
                Spacer()
                Image(systemName: SFImageNameFor(tab: tab))
                    .font(.title)
                    .foregroundColor(fillColorFor(tab: tab))
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
        }
    }
    
    func SFImageNameFor(tab: CalculatorViewTab) -> String {
        switch tab {
        case .mainCalculator:
            return "plus.forwardslash.minus"
        case .settings:
            return "gearshape.2"
        case .history:
            return "archivebox"
        }
    }
    
    func fillColorFor(tab: CalculatorViewTab) -> Color {
        if selectedTab == tab { return .orange }
        else { return .gray }
    }
}

struct CustomCalculatorTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalculatorTabView(selectedTab: .constant(.mainCalculator))
            .padding(.horizontal)
    }
}
