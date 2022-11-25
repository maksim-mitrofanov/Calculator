//
//  EmptyHistorySheetView.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 24.10.2022.
//

import SwiftUI
import Lottie

struct EmptyHistorySheetView: View {
    let theme: CalculatorTheme
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    private let animationName = "LottieNotFoundAnim"
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    


    var body: some View {
        ZStack {
            theme.data.backgroundColor.edgesIgnoringSafeArea(.all)
            
            if verticalSize == .regular { portraitOrientationView }
            else { landscapeOrientationView }
        }
    }
    
    var portraitOrientationView: some View {
        VStack {
            titleView
            mainTextView
            lottieAnimation
            
        }
    }
    
    var landscapeOrientationView: some View {
        HStack {
            VStack {
                titleView
                mainTextView
                                
                dismissButton
                    .padding(.top)
            }
            lottieAnimation
        }
    }
    
    var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Dismiss")
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
        }
    }
    
    var titleView: some View {
        Text("Oops!")
            .font(.largeTitle)
            .padding(.bottom, 3)
    }
    
    var mainTextView: some View {
        Text("Looks like your history is empty")
            .font(.body)
    }
    
    var lottieAnimation: some View {
        LottieView(fileName: animationName)
            .frame(width: getAnimationDimensions().width, height: getAnimationDimensions().height)
    }
    
    func getAnimationDimensions() -> CGSize {
        if verticalSize == .regular {
            return CGSize(width: screenWidth, height: screenWidth)
        }
        
        else {
            return CGSize(width: screenHeight, height: screenHeight)
        }
    }
}
