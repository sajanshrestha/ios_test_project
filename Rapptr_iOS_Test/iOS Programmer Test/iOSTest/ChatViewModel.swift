//
//  ChatViewModel.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    var messages = [Message]() {
        didSet {
            isLoading = false
            delegate.didSetMessages()
        }
    }
    
    var delegate: ChatMessageDelegate!
    
    var isLoading = true
    
    init() {
        ChatClient.getMessages { messages in
            self.messages = messages
        }
    }
}


protocol ChatMessageDelegate {
    func didSetMessages()
}
