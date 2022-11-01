//
//  GeometryReaderTest.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 01.11.2022.
//

import SwiftUI

struct GeometryReaderTest: View {
    let geometryProxy: GeometryProxy
    
    var body: some View {
        Rectangle()
            .stroke()
            .overlay {
                VStack {
                    Text("Width: \(geometryProxy.size.width)")
                    Text("Height: \(geometryProxy.size.height)")
                }
            }
    }
}

struct GeometryReaderTest_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            GeometryReaderTest(geometryProxy: proxy)
        }
    }
}
