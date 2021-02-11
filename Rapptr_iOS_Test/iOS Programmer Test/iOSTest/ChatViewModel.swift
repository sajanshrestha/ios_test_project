//
//  ChatViewModel.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    var chatClient: ChatClient?
    
    var messages = [Message]() {
        didSet {
            isLoading = false
            delegate.didSetMessages()
        }
    }
    
    var delegate: ChatMessageDelegate!
    
    var isLoading = true
    
    init() {
        chatClient = ChatClient()
        chatClient?.fetchChatData({ messages in
            if let messages = messages {
                self.messages = messages
            }
        }, withError: { error in
            print(error!)
        })
    }
}


protocol ChatMessageDelegate {
    func didSetMessages()
}
