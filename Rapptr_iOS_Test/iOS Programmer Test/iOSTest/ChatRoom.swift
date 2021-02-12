//
//  ChatViewModel.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class ChatRoom {
    
    var messages = [Message]() {
        didSet {
            // this delay is just to simulate a little longer network call
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isLoadingMessages = false
                self.delegate.didSetMessages()
            }
        }
    }
    
    var delegate: ChatMessageDelegate!
    
    var isLoadingMessages = true
    
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
    
    private var chatClient: ChatClient!
    
    func cachedAvatarImage(for string: String) -> UIImage? {
        cachedAvatarImages[string]
    }
    
    func cacheAvatarImage(_ image: UIImage, key: String) {
        cachedAvatarImages[key] = image
    }
    
    private var cachedAvatarImages = [String: UIImage]()
}


protocol ChatMessageDelegate {
    func didSetMessages()
}
