//
//  BaseCell.swift
//  TSPapp
//
//  Created by Adnan Shoukfeh on 9/1/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
