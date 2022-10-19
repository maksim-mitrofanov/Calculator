//
//  SoundManager.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import Foundation
import AVKit

import AVFoundation

class SoundManager {
    private init() {
        guard let url = Bundle.main.url(forResource: "buttonClick", withExtension: ".mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Error while playing audio. \(error.localizedDescription)")
        }
    }
    
    static let instance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
    
    func playButtonTapSound() {
        AudioServicesPlaySystemSound(1104)
    }
}
