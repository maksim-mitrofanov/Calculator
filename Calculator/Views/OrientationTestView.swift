//
//  OrientationTestView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 07.10.2022.
//

import SwiftUI

struct OrientationTestView: View {
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [Color.blue, Color.red], startPoint: .leading, endPoint: .trailing))
                .frame(width: getLabelWidth(), height: getLabelHeight())
            
                .overlay {
                    Text(heightSizeClass == .regular ? "Portrait" : "Landscape")
                        .foregroundColor(.white)
                }
        }
//        .onChange(of: heightSizeClass) { newValue in
//            print(heightSizeClass.debugDescription)
//
//            withAnimation {
//                if newValue == .regular { orientation = .portrait }
//                else { orientation = .landscapeLeft }
//            }
//        }
    }
    
    func getLabelWidth() -> CGFloat {
        if heightSizeClass == .compact { return screenHeight / 2 }
        else { return screenWidth / 1.5 }
    }
    
    func getLabelHeight() -> CGFloat {
        if heightSizeClass == .compact { return screenWidth / 6 }
        else { return screenHeight / 12 }
    }
}

struct OrientationTestView_Previews: PreviewProvider {
    static var previews: some View {
        OrientationTestView()
    }
}
