//
//  ImageDownloader.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/12/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

struct ImageClient {
    static func image(for url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data)
        }.resume()
    }
}
