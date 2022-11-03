//
//  PageView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 02.11.2022.
//

import SwiftUI

struct TestPageView: View {
    let colours = [Color.red, Color.blue, Color.orange, Color.green]
    
    @State private var currentColorIndex: Int = 0
    @State private var currentRectOffset: CGFloat = 0
    
    @State private var insertionTransitionEdge: Edge = .trailing
    @State private var removalTransitionEdge: Edge = .leading

    
    var body: some View {
        ZStack {
            //Background Color
            Color(uiColor: UIColor.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
            
            //PageView (better name?)
            VStack {
                VStack {
                    switch currentColorIndex {
                    case 0:
                        TabPageRepresentation(
                            index: currentColorIndex,
                            colour: colours[currentColorIndex],
                            insertionTransitionEdge: insertionTransitionEdge,
                            removalTransitionEdge: removalTransitionEdge)
                        
                    case 1:
                        TabPageRepresentation(
                            index: currentColorIndex,
                            colour: colours[currentColorIndex],
                            insertionTransitionEdge: insertionTransitionEdge,
                            removalTransitionEdge: removalTransitionEdge)
                        
                    case 2:
                        TabPageRepresentation(
                            index: currentColorIndex,
                            colour: colours[currentColorIndex],
                            insertionTransitionEdge: insertionTransitionEdge,
                            removalTransitionEdge: removalTransitionEdge)
                        
                    case 3:
                        TabPageRepresentation(
                            index: currentColorIndex,
                            colour: colours[currentColorIndex],
                            insertionTransitionEdge: insertionTransitionEdge,
                            removalTransitionEdge: removalTransitionEdge)
                        
                    default:
                        TabPageRepresentation(
                            index: currentColorIndex,
                            colour: colours[currentColorIndex],
                            insertionTransitionEdge: insertionTransitionEdge,
                            removalTransitionEdge: removalTransitionEdge)
                    }
                }
                .offset(x: currentRectOffset)
                .gesture(
                    DragGesture(minimumDistance: 5)
                        .onChanged(dragGestureValueChanged(to:))
                        .onEnded(dragGestureEnded(with:))
                )
                
                currentIndexIndicators
                    .padding(.top)
            }
        }
    }
    
    var currentIndexIndicators: some View {
        HStack {
            ForEach(colours, id: \.self) { color in
                Circle().frame(width: 7, height: 7)
                    .foregroundColor(colours[currentColorIndex] == color ? .white : .gray )
            }
        }
    }
    
    struct TabPageRepresentation: View {
        let index: Int
        let colour: Color
        let insertionTransitionEdge: Edge
        let removalTransitionEdge: Edge
        
        var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 20).frame(width: 300, height: 250)
                    .overlay {
                        SingleExtraButtonsRowView(theme: .lightTheme, buttons: ButtonStorage.extraRowButtonsWithDataShort)
                    }
                    .foregroundColor(colour)
            }
            .transition(.asymmetric(insertion: .move(edge: insertionTransitionEdge), removal: .move(edge: removalTransitionEdge)))
        }
    }
    
    func dragGestureValueChanged(to newValue: DragGesture.Value) {
        withAnimation {
            if abs(newValue.translation.width) < 20 {
                currentRectOffset = newValue.translation.width
            }
        }
    }
    
    func dragGestureEnded(with newValue: DragGesture.Value) {
        if newValue.translation.width < -15 {
            insertionTransitionEdge = .trailing
            removalTransitionEdge = .leading
            
            withAnimation {
                currentColorIndex += 1
                
                if currentColorIndex == colours.count {
                    currentColorIndex = 0
                }
            }
        }
        
        else if newValue.translation.width > 15 {
            insertionTransitionEdge = .leading
            removalTransitionEdge = .trailing
            
            withAnimation {
                if currentColorIndex == 0 { currentColorIndex = colours.count - 1}
                else if currentColorIndex > 0 { currentColorIndex -= 1 }
                
            }
            
        }
        
        withAnimation {
            currentRectOffset = 0
        }
    }
}

struct TestPageViewWithSingleObject_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello")
            TestPageView()
        }
    }
}
