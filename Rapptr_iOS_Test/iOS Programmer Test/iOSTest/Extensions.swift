//
//  Extension + UIView.swift
//  iOSTest
//
//  Created by Sajan Shrestha on 2/12/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

extension UIView {
    func fade(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.layer.opacity = self.layer.opacity == 0.0 ? 1.0 : 0.0
        }
    }
}
