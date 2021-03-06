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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isLoading = false
                self.delegate.didSetMessages()
            }
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
    
    private var chatClient: ChatClient?

    
    func avatarImage(for string: String) -> UIImage? {
        cachedAvatarImages[string]
    }
    
    func cacheAvatarImage(key: String, image: UIImage) {
        cachedAvatarImages[key] = image
    }
    
    private var cachedAvatarImages = [String: UIImage]()
}


protocol ChatMessageDelegate {
    func didSetMessages()
}
