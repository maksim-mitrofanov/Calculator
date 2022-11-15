//
//  TextCopiedBanner.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import SwiftUI

struct TextCopiedBanner: View {
    @State private var rotation: Double = 0
    
    @Binding var isFaceUP: Bool
    var numberCopied: String
    let theme: CalculatorTheme
    
    var delay: Double = 0.3
    var rotationAxis: RotationAxisEnum = .x
    
    
    enum RotationAxisEnum {
        case x, y, z
    }
    
    
    var body: some View {
        VStack {
            Text(numberCopied + " was copied to cliboard")
                .modifier(RotatablePopUPBackground(rotation: rotation, rotationAxis: rotationAxis, isFaceUP: isFaceUP))
            
        }
        .onAppear() {
            if isFaceUP { rotation = 0 }
            else { rotation = 180 }
        }
        
        .onChange(of: isFaceUP) { newValue in
            withAnimation(.easeInOut.delay(delay)) {
                rotation += 180
            }
            if rotation == 360 { rotation = 0; isFaceUP = true }
        }
    }
}

struct RotatablePopUPBackground: AnimatableModifier {
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    var rotationAxis: TextCopiedBanner.RotationAxisEnum
    var isFaceUP: Bool
    
    private var isTextVisible: Bool {
        if isFaceUP {
            print("Turning face up. Rotation: \(rotation)")
            if rotation > -90 || rotation == 0 { return true }
            else { return false }
        }
        
        else {
            print("Turning face down. Rotation: \(rotation)")
            if rotation < 90 { return true }
            else { return false }
        }
    }
    
    func body(content: Content) -> some View {
        switch rotationAxis {
        case .x:
            getMainContent(content: content)
                .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0, z: 0))
        case .y:
            getMainContent(content: content)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        case .z:
            getMainContent(content: content)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 0, z: 1))
        }
    }
    
    func getMainContent(content: Content) -> some View {
        content
            .opacity(isTextVisible ? 1 : 0)
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
            .cornerRadius(15)
    }
}

struct TextCopiedBanner_Previews: PreviewProvider {
    static var previews: some View {
        TextCopiedBanner(isFaceUP: .constant(true), numberCopied: 34.description, theme: .lightTheme)
    }
}
