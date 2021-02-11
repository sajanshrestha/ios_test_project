//
//  ChatClient.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

struct ChatClient {
    
    static func getMessages(completion: @escaping (([Message]) -> Void)) {
        
        guard let url = URL(string: Endpoint.chatMessagesUrl) else { return }
        
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

struct Endpoint {
    static let chatMessagesUrl = "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php"
    static let loginUrl = "http://dev.rapptrlabs.com/Tests/scripts/login.php"
}
