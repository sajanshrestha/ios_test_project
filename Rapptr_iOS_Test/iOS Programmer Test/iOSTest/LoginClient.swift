//
//  LoginClient.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

struct LoginClient {
    
    static func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: Endpoint.loginUrl) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                completion(true)
            }
            else {
                completion(false)
            }
        }.resume()
    }
}
