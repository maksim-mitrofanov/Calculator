//
//  CalculatorView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

struct CalculatorView: View {
    var buttonGridData: [[String]] {
        return [["1"]]
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
