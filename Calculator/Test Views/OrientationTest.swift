//
//  OrientationTest.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 24.10.2022.
//

import SwiftUI

struct OrientationTest: View {
    @Environment(\.verticalSizeClass) var verticalSize: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSize: UserInterfaceSizeClass?

    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        if verticalSize == .regular {
            Button("Portrait") {
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                Text("Sheet")
            }
        }
        
        else {
            Button("Lanscape") {
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                Button("Hide sheet") {
                    isSheetPresented = false
                }
            }
        }
    }
}

struct OrientationTest_Previews: PreviewProvider {
    static var previews: some View {
        OrientationTest()
    }
}
