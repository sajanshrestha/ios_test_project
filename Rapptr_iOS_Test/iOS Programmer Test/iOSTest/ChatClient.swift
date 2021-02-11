//
//  ChatClient.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

struct ChatClient {
    static func getMessages(completion: @escaping (([MyMessage]) -> Void)) {
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
                completion(messageResponse.data)
            }
            catch {
                print("error fetching data")
            }
        }.resume()
    }
}


struct MessageResponse: Codable {
    var data: [MyMessage]
}

struct MyMessage: Codable {
    var userId: String
    var name: String
    var avatarUrl: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case avatarUrl = "avatar_url"
        case message
    }
}

class ChatViewModel {
    var messages = [MyMessage]() {
        didSet {
            delegate.didSetMessages()
        }
    }
    
    var delegate: ChatMessageDelegate!
    
    init() {
        ChatClient.getMessages { messages in
            DispatchQueue.main.async {
                self.messages = messages
            }
        }
    }
}


protocol ChatMessageDelegate {
    func didSetMessages()
}
