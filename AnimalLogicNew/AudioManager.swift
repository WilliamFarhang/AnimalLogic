//
//  AudioManager.swift
//  AnimalLogicNew
//
//  Created by william farhang on 2024-08-06.
//

import AVFoundation

class AudioManager: ObservableObject {
    private var player: AVAudioPlayer?

    func playSound(for animal: Animal) {
        let soundFileName = "yeling" // Specify the name of your sound file without extension
        
        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav") else {
            print("Sound file not found for \(soundFileName)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
