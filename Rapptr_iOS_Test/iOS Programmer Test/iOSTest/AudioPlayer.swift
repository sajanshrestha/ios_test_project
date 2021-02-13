//
//  AudioPlayer.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/12/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation
import AVFoundation

struct AudioPlayer {
    
    static func playSound(with file: String) {
        
        guard let soundUrl = Bundle.main.url(forResource: file, withExtension: "mp3") else { return }
        var sound: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &sound)
        
        AudioServicesPlaySystemSoundWithCompletion(sound) {
            AudioServicesDisposeSystemSoundID(sound)
        }
    }
}
