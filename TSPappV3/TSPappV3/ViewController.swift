//
//  ViewController.swift
//  TSPappV3
//
//  Created by Adnan Shoukfeh on 12/23/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch: class {
    func dropPinZoomIn(placeMark: MKPlacemark)
    //implementation for func goes elsewhere
}

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    var currentAnnotation = MKPointAnnotation()
    var currentLocationName = String()
    let background = UIView()
    let DestinationViewController = AddDestinationViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initial set up
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        //set up search results table
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        
        //set up the search bar
        //configures search bar and embeds it within navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        //navigationItem.searchController = resultSearchController
        
        
        //configure UISearchController appearance
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        
        //passes handle of the mapView from main ViewController onto locationSearchTable
        locationSearchTable.mapView = mapView
        
        //wire up protocol
        locationSearchTable.handleMapSearchDelegate = self
        
        
    }
    
    func userChoice() {
        //allow user to choose whether to add or cancel
        
        DestinationViewController.cancelButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        DestinationViewController.locationLabel.text = currentLocationName
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //self.background.alpha = 1
            self.showPopUp()
        }, completion: nil)

    }


    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.DestinationViewController.view.removeFromSuperview()
        }
        
        self.mapView.removeAnnotation(currentAnnotation)
        let searchBar = resultSearchController!.searchBar
        searchBar.text = ""
        if mapView.annotations.capacity == 1 {
            locationManager.requestLocation()
        }

    }

    
    func showPopUp() {
        let margins = view.layoutMarginsGuide
        let mapMargins = mapView.layoutMarginsGuide
        addChild(DestinationViewController)
        view.addSubview(DestinationViewController.view)
        DestinationViewController.didMove(toParent: self)
        
        DestinationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        DestinationViewController.view.leadingAnchor.constraint(equalToSystemSpacingAfter: mapMargins.leadingAnchor, multiplier: 1).isActive = true
        
        mapMargins.trailingAnchor.constraint(equalToSystemSpacingAfter: DestinationViewController.view.trailingAnchor, multiplier: 1).isActive = true
        
        margins.bottomAnchor.constraint(equalToSystemSpacingBelow: DestinationViewController.view.bottomAnchor, multiplier: 2).isActive = true
    }
}


extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            //print("location:: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
    
}


extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placeMark: MKPlacemark) {
        //cache the pin, usefuel when need location later
        selectedPin = placeMark
        
        //clear existing pins
        //mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeMark.coordinate
        annotation.title = placeMark.name
        
        if let city = placeMark.locality,
            let state = placeMark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: placeMark.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        //DO STUFF FOR POP UP
        self.currentLocationName = annotation.title!
        self.currentAnnotation = annotation
        self.userChoice()
        
    }
} //extension


