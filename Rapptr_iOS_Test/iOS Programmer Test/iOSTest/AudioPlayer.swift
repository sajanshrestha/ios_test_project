//
//  AudioPlayer.swift
//  MathForFun
//
//  Created by Sajan Shrestha on 7/3/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import AVFoundation

struct AudioPlayer {
        
    static var audioPlayer: AVAudioPlayer!
    
    static func playSound(for file: String) {
        
        guard let sound = Bundle.main.path(forResource: file, ofType: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.play()
            
        } catch {
            print("error playing sound")
        }
        
    }
}
