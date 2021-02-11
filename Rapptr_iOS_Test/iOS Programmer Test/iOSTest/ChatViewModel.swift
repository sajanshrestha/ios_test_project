//
//  ChatViewModel.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    var messages = [Message]() { didSet { delegate.didSetMessages() } }
    
    var delegate: ChatMessageDelegate!
    
    init() {
        ChatClient.getMessages { messages in
            self.messages = messages
        }
    }
}


protocol ChatMessageDelegate {
    func didSetMessages()
}
