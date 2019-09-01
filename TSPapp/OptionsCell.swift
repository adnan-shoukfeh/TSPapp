//
//  OptionsCell.swift
//  TSPapp
//
//  Created by Adnan Shoukfeh on 9/1/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit

class OptionsCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "FILLER"
        return label
    }()
    
    override func setUpViews() {
        super.setUpViews()
        backgroundColor = UIColor.blue
        addSubview(nameLabel)
    
    }
}
