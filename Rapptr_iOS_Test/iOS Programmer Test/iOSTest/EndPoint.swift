//
//  EndPoint.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/11/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

enum EndPoint {
    case chat
    case login
    
    var url: URL? {
        switch self {
        case .chat:
            return URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")
        case .login:
            return URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")
        }
    }
}
