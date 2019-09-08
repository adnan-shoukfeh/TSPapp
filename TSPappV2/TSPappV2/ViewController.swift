//
//  ViewController.swift
//  TSPappV2
//
//  Created by Adnan Shoukfeh on 9/2/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    let mapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addMapAndConstraints()
        addSearchBarAndConstraints()
        showPopUp()
        
    }
    
    func addSearchBarAndConstraints() {
        let searchBar = UISearchBar()
        let safeAreaView = view.safeAreaLayoutGuide
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Enter location..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaView.topAnchor, multiplier: 1).isActive = true
        searchBar.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 1).isActive = true
        searchBar.leadingAnchor.constraint(equalToSystemSpacingAfter: mapView.leadingAnchor, multiplier: 1).isActive = true
        mapView.trailingAnchor.constraint(equalToSystemSpacingAfter: searchBar.trailingAnchor, multiplier: 1).isActive = true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
    }
    
    
    func addMapAndConstraints() {
        view.addSubview(mapView)
        let safeAreaView = view.safeAreaLayoutGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0).isActive = true
        safeAreaView.bottomAnchor.constraint(equalToSystemSpacingBelow: mapView.bottomAnchor, multiplier: 0).isActive = true
        mapView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaView.leadingAnchor, multiplier: 0).isActive = true
        safeAreaView.trailingAnchor.constraint(equalToSystemSpacingAfter: mapView.trailingAnchor, multiplier: 0).isActive = true

    }
    
    func showPopUp() {
        
        let DestinationViewController = AddDestinationViewController()
        addChild(DestinationViewController)
        view.addSubview(DestinationViewController.view)
        DestinationViewController.didMove(toParent: self)
        
        DestinationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        DestinationViewController.view.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: DestinationViewController.view.trailingAnchor, multiplier: 1).isActive = true
        
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: DestinationViewController.view.bottomAnchor, multiplier: 1).isActive = true
    }

}

