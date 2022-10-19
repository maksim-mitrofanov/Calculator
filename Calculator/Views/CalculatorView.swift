//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 05.09.2022.
//

import SwiftUI


struct CalculatorView: View {
    @State private var isExtraButtonsRowExpanded: Bool = false
    @State private var isBackgroundExpanded: Bool = true
    @State private var currentTheme: CalculatorTheme = .lightTheme
    @State private var isHistorySheetPresented: Bool = false
    @State private var isExpandableBackgroundExpanded: Bool = true
    @State private var currentNumLeadingPadding: CGFloat = 0
    @State private var currentNumTrailingPadding: CGFloat = 10
    
    @StateObject private var mathManager = MathManager.instance
    
            
    var body: some View {
        ZStack {
            backgroundColorFill
            topBarButtons
            ExpandableBackgroundView(theme: currentTheme, isExpanded: isExpandableBackgroundExpanded)
            currentNumberAndButtonGrid
            
        }
        .sheet(isPresented: $isHistorySheetPresented) {
            HistoryView(theme: currentTheme)
        }
    }
    
    var backgroundColorFill: some View {
        Rectangle()
            .foregroundColor(currentTheme.data.backgroundColor)
            .edgesIgnoringSafeArea(.all)
    }
    
    var currentNumberAndButtonGrid: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(MathManager.instance.currentNumber)
                    .font(Font.system(size: 55))
                    .lineLimit(1)
                    .padding(.bottom, isExtraButtonsRowExpanded ? 10 : 0)
                    .padding(.trailing, currentNumTrailingPadding)
                    .offset(x: currentNumLeadingPadding)

                
                    .minimumScaleFactor(0.6)
                    .foregroundColor(currentTheme == .lightTheme ? .black : .white)
                
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged { value in
                                withAnimation {
                                    if value.translation.width < 0 {
                                        currentNumTrailingPadding = 15
                                    }
                                    else if value.translation.width > 0 {
                                        currentNumLeadingPadding = 15
                                    }
                                }
                            }
                            .onEnded { value in
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    currentNumTrailingPadding = 0
                                    currentNumLeadingPadding = 0
                                }
                                
                                if value.translation.width < 0 {
                                    MathManager.instance.receiveRemoveLastSwipe()
                                    HapticsManager.instance.impact(style: .soft)
                                }
                                else if value.translation.width > 0 {
                                    MathManager.instance.receiveRemoveFirstSwipe()
                                    HapticsManager.instance.impact(style: .soft)
                                }
                            }
                    )
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9)

            
            CalculatorButtonsGrid(isExtraButtonRowExpanded: isExtraButtonsRowExpanded, theme: currentTheme)
        }
    }
    
    var expansionButton: some View {
        Button {
            withAnimation {
                isExtraButtonsRowExpanded.toggle()
                isExpandableBackgroundExpanded = true
            }
        } label: {
            Image(systemName: expansionButtonImageName)
        }
    }
    
    var showAllHistoryButton: some View {
        Button {
            withAnimation {
                isHistorySheetPresented = true
                isExpandableBackgroundExpanded = true
            }
        } label: {
            Image(systemName: showHistoryImageName)
        }
    }
    
    var topBarButtons: some View {
        VStack {
            HStack {
                ThemePicker(currentTheme: $currentTheme)
                Spacer()
                
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
            .padding(.top)
            .padding()
            
            Spacer()
        }
    }
    
    private let showHistoryImageName = "clock.arrow.circlepath"
    private let expandImageName = "arrow.up.left.and.arrow.down.right"
    private let collapseImageName = "arrow.down.right.and.arrow.up.left"
    
    var expansionButtonImageName: String {
        isExtraButtonsRowExpanded ? collapseImageName : expandImageName
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

struct CalcViewDefVals {
    static let cornerRadius: CGFloat = 42
    static let shadowRadius: CGFloat = 25
    
    static let screenHeight = UIScreen.main.bounds.height
    static let minTopOffset = screenHeight / 40
    static let maxTopOffset = screenHeight / 9
    static let extraOffset: CGFloat = 20
}
