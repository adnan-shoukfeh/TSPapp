//
//  AddDestinationView.swift
//  TSPappV3
//
//  Created by Adnan Shoukfeh on 12/25/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import Foundation
import UIKit

class AddDestinationViewController: UIViewController {
    
    var locationLabel = UILabel()
    let cancelButton = UIButton()
    let goButton = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 15
        
        goButton.setTitle("Add Destination", for: .normal)
        goButton.titleLabel?.textColor = .white
        goButton.backgroundColor = UIColor(red: 83/255, green: 215/255, blue: 105/255, alpha: 1)
        goButton.layer.cornerRadius = 10
        goButton.titleLabel?.font = UIFont(name: "Avenir", size: 25.0)
        let xButton = #imageLiteral(resourceName: "XButtonTransparent")
        cancelButton.setImage(xButton, for: .normal)
        
        
        locationLabel.textColor = .white
        //locationLabel.text = "Location Title"
        locationLabel.font = UIFont(name: "Avenir", size: 30.0)
        locationLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(locationLabel)
        view.addSubview(cancelButton)
        view.addSubview(goButton)
        addConstraints()
    }
    
    func addConstraints() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false

        /*
        locationLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        locationLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1).isActive = true
        
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: locationLabel.trailingAnchor, multiplier: 1).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: locationLabel.bottomAnchor, multiplier: 1).isActive = true
        */
        
        //set label constraints
        locationLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 2).isActive = true
        locationLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2).isActive = true
        
        //set Go button constraints
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: goButton.bottomAnchor, multiplier: 3).isActive = true
        goButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: goButton.trailingAnchor, multiplier: 2).isActive = true
        goButton.topAnchor.constraint(equalToSystemSpacingBelow: locationLabel.bottomAnchor, multiplier: 5).isActive = true
        goButton.topAnchor.constraint(equalToSystemSpacingBelow: cancelButton.bottomAnchor, multiplier: 5).isActive = true
        
        //set Cancel button constraints
        cancelButton.leadingAnchor.constraint(equalToSystemSpacingAfter: locationLabel.trailingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: cancelButton.trailingAnchor, multiplier: 2).isActive = true
        cancelButton.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 1).isActive = true
        
        //cancelButton.addTarget(self, action: #selector(), for: <#T##UIControl.Event#>)
        
        }
    
}

