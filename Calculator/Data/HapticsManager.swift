//
//  HapticsManager.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import SwiftUI
import Foundation

class HapticsManager {
    static let instance = HapticsManager()
    private init() { }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    public func triggerNotification(for buttonData: CalculatorButtonData) {
        if buttonData.operationType == .removeLast || buttonData.operationType == .allClear {
            impact(style: .medium)
        }
    }
}
