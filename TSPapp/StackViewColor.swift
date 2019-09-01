//
//  StackViewColor.swift
//  TSPapp
//
//  Created by Adnan Shoukfeh on 9/1/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
