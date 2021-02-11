//
//  Message.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

struct MessageResponse: Codable {
    var data: [Message]
}

struct Message: Codable {
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
