//
//  CalculatorApp.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

@main
struct CalculatorApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .onChange(of: scenePhase, perform: { newValue in
                    if newValue != .active {
                        MathManager.instance.saveAllHistory()
                    }
                })
        }
    }
}
