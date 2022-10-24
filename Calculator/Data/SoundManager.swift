//
//  SoundManager.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import Foundation

import AVFoundation

class SoundManager {
    private init() { }
    static let instance = SoundManager()
        
    func playButtonTapSound() {
        AudioServicesPlaySystemSound(1104)
    }
}
