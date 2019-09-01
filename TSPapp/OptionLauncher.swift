//
//  OptionLauncher.swift
//  TSPapp
//
//  Created by Adnan Shoukfeh on 9/1/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit

class OptionsLauncher: NSObject {
    
    //declare outside in order to access in several functions
    let mapInBackground = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func userChoice() {
        //allow user to choose whether to add or cancel
        
        if let window = UIApplication.shared.keyWindow {
            
            mapInBackground.backgroundColor = UIColor(white: 0, alpha: 0.15)
            
            mapInBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(mapInBackground)
            
            window.addSubview(collectionView)
            
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            mapInBackground.frame = window.frame
            mapInBackground.alpha = 0
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.mapInBackground.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            
        }
    }//userChoice
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.mapInBackground.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.width)
            }
            
        }
        
    }
    
    
    override init() {
        super.init()
        //START
    }
}
