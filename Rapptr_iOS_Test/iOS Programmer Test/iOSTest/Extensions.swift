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

extension UITextField {
    func setTextInset(left: CGFloat = 24, right: CGFloat = 24) {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
        self.leftView = leftPadding
        self.leftViewMode = .always
        
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
        self.rightView = rightPadding
        self.rightViewMode = .always
    }
}
