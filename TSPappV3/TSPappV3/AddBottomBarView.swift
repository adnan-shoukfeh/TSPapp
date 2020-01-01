//
//  AddBottomBarView.swift
//  TSPappV3
//
//  Created by Adnan Shoukfeh on 12/30/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import Foundation
import UIKit

class AddBottomBarViewController: UIViewController {
    
    let resetButton = UIButton()
    let calcButton = UIButton()
    
    override func viewDidLoad() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        calcButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.textColor = .white
        resetButton.backgroundColor = UIColor(red: 20/255, green: 121/255, blue: 243/255, alpha: 1)
        resetButton.layer.cornerRadius = 10
        resetButton.titleLabel?.font = UIFont(name: "Avenir", size: 15.0)
        let resetImage = UIImage(systemName: "arrow.counterclockwise")
        resetButton.setImage(resetImage, for: .normal)
        resetButton.tintColor = .white
        

        
        calcButton.setTitle("Calculate", for: .normal)
        calcButton.titleLabel?.textColor = .white
        calcButton.backgroundColor = UIColor(red: 20/255, green: 121/255, blue: 243/255, alpha: 1)
        calcButton.layer.cornerRadius = 10
        calcButton.titleLabel?.font = UIFont(name: "Avenir", size: 15.0)
        let calcImage = UIImage(systemName: "arrow.turn.down.right")
        calcButton.setImage(calcImage, for: .normal)
        calcButton.tintColor = .white
        
        
        /*
        let imageWidth = resetButton.imageView!.frame.width
        let textWidth = ("Calculate" as NSString).size(withAttributes:[NSAttributedString.Key.font:resetButton.titleLabel!.font!]).width
        let width = imageWidth + textWidth + 24
        
        resetButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        calcButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        
         
        resetButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        calcButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        calcButton.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        */
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 50
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.insertArrangedSubview(resetButton, at: 0)
        stackView.insertArrangedSubview(calcButton, at: 1)
        //stackView.addSubview(resetButton)
        //stackView.addSubview(calcButton)
        //stackView.addArrangedSubview(resetButton)
        //stackView.addArrangedSubview(calcButton)
        view.addSubview(stackView)
        
        
    }
    
}
