//
//  SoundManager.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import Foundation
import AVKit

class SoundManager {
    private init() { }
    static let instance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
    
    func playButtonTapSound() {
        guard let url = Bundle.main.url(forResource: "buttonClick", withExtension: ".mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error while playing audio. \(error.localizedDescription)")
        }
    }
}
