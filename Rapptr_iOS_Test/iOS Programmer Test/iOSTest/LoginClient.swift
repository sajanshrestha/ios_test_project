//
//  LoginClient.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/10/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

struct LoginClient {
    
    
        
    static func login(email: String, password: String, completion: @escaping (Bool, TimeInterval?) -> Void) {
        
        let startDate = Date()
        
        guard var urlComponents = URLComponents(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php") else { return }
        let emailQuery = URLQueryItem(name: "email", value: email)
        let passwordQuery = URLQueryItem(name: "password", value: password)
        urlComponents.queryItems = [emailQuery, passwordQuery]
                
        guard let url = urlComponents.url else { return }
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                let executionTime = Date().timeIntervalSince(startDate)
                completion(true, executionTime)
            }
            else {
                completion(false, nil)
            }
        }.resume()
    }
}
