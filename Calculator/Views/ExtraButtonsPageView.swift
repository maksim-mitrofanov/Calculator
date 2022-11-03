//
//  ExtraButtonsPageView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 03.11.2022.
//

import SwiftUI

struct ExtraButtonsPageView: View {
    private let pages = [
        SinglePageData(buttons: ButtonStorage.extraRowButtonsWithDataShort),
        SinglePageData(buttons: ButtonStorage.extraRowButtonsWithDataShort),
        SinglePageData(buttons: ButtonStorage.extraRowButtonsWithDataShort),
        SinglePageData(buttons: ButtonStorage.extraRowButtonsWithDataShort)
    ]
    
    @State private var currentPageIndex: Int = 0
    @State private var currentPageOffset: CGFloat = 0

    @State private var insertionAnimationEdge: Edge = .trailing
    @State private var removalAnimationEdge: Edge = .leading

    
    var body: some View {
        VStack {
            VStack {
                switch currentPageIndex {
                case 0:
                    SinglePageView(
                        insertionAnimationEdge: insertionAnimationEdge,
                        removalAnimationEdge: removalAnimationEdge,
                        buttons: pages[currentPageIndex].buttons
                    )
                case 1:
                    SinglePageView(
                        insertionAnimationEdge: insertionAnimationEdge,
                        removalAnimationEdge: removalAnimationEdge,
                        buttons: pages[currentPageIndex].buttons
                    )
                case 2:
                    SinglePageView(
                        insertionAnimationEdge: insertionAnimationEdge,
                        removalAnimationEdge: removalAnimationEdge,
                        buttons: pages[currentPageIndex].buttons
                    )
                case 3:
                    SinglePageView(
                        insertionAnimationEdge: insertionAnimationEdge,
                        removalAnimationEdge: removalAnimationEdge,
                        buttons: pages[currentPageIndex].buttons
                    )

                default:
                    SinglePageView(
                        insertionAnimationEdge: insertionAnimationEdge,
                        removalAnimationEdge: removalAnimationEdge,
                        buttons: pages[currentPageIndex].buttons
                    )
                }
            }
            .offset(x: currentPageOffset)
            .gesture(
                DragGesture(minimumDistance: 5)
                    .onChanged(dragGestureValueChanged(to:))
                    .onEnded(dragGestureEnded(with:))
            )
            
            Button("Next") {
                withAnimation {
                    currentPageIndex += 1
                    if currentPageIndex == pages.count - 1 { currentPageIndex = 0 }
                }
            }
        }
    }
    
    func dragGestureValueChanged(to newValue: DragGesture.Value) {
        withAnimation {
            if abs(newValue.translation.width) < 100 {
                currentPageOffset = newValue.translation.width
            }
        }
    }
    
    func dragGestureEnded(with newValue: DragGesture.Value) {
        if newValue.translation.width < -100 {
            insertionAnimationEdge = .trailing
            removalAnimationEdge = .leading
            
            withAnimation {
                currentPageIndex += 1
                
                if currentPageIndex == pages.count {
                    currentPageIndex = 0
                }
            }
        }
        
        else if newValue.translation.width > 100 {
            insertionAnimationEdge = .leading
            removalAnimationEdge = .trailing
            
            withAnimation {
                if currentPageIndex == 0 { currentPageIndex = pages.count - 1 }
                else if currentPageIndex > 0 { currentPageIndex -= 1 }
                
            }
            
        }
        
        withAnimation {
            currentPageOffset = 0
        }
    }
    
    
    
    struct SinglePageView: View {
        let insertionAnimationEdge: Edge
        let removalAnimationEdge: Edge
        let buttons: [CalculatorButtonData]
        
        var body: some View {
            VStack {
                VStack {
                    SingleExtraButtonsRowView(theme: .lightTheme, buttons: buttons)
                    SingleExtraButtonsRowView(theme: .lightTheme, buttons: buttons)
                }
                .disabled(true)
                .padding()
                .background(Color(uiColor: .systemGroupedBackground))
                .cornerRadius(20)
            }
            
            .transition(
                .asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                )
            )
        }
    }
    
    struct SinglePageData: Hashable {
        let buttons: [CalculatorButtonData]
        let id: String = UUID().uuidString
    }
}

struct ExtraButtonsPageView_Previews: PreviewProvider {
    static var previews: some View {
        ExtraButtonsPageView()
    }
}
