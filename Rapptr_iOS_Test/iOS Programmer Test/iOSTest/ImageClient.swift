//
//  ImageDownloader.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/12/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

struct ImageDownloader {
    
    static func downloadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
}
