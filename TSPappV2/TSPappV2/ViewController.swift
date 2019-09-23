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
    let searchBar = UISearchBar()
    let mapView = MKMapView()
    var currentAnnotation = MKPointAnnotation()
    var currentLocationName = String()
    
    let background = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addMapAndConstraints()
        addSearchBarAndConstraints()
        
    }
    
    func addSearchBarAndConstraints() {
        
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
        
        //self.navigationItem.titleView = searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){//} textDidChange textSearched: String) {
        //let searchController = UISearchController(searchResultsController: nil)
        //searchController.searchBar.delegate = self
        //present(searchController, animated: true, completion: nil)
        
        //ignore user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //hide search bar and keyboard
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //create search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        //searchRequest.naturalLanguageQuery = textSearched
        
        //start a search based on above request
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        //either get response or error
        activeSearch.start { (response, error) in
            
            //deal with left over activity indicator
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            
            if response == nil {
                //PRINT ALERT LATER
                print("Error")
            } else {
                //remove annotations
                /*
                 let annotations = self.mapView.annotations
                 self.mapView.removeAnnotations(annotations)
                 */
                
                //get data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //create new annotation based on data
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.currentAnnotation = annotation
                self.mapView.addAnnotation(annotation)
                
                self.currentLocationName = annotation.title!
                
                //zoom in
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
                //present option to either add or cancel
                self.userChoice()
                //let optionsLauncher = OptionsLauncher()
                //optionsLauncher.userChoice()
                
            }
        }//activeSearch
        
    }//func
    
    func userChoice() {
        //allow user to choose whether to add or cancel
        if let window = UIApplication.shared.keyWindow {
            background.backgroundColor = UIColor(white: 0, alpha: 0.1)
            background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(background)
            
            background.frame = window.frame
            background.alpha = 0
            
            DestinationViewController.cancelButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            DestinationViewController.locationLabel.text = currentLocationName
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.background.alpha = 1
                self.showPopUp()
            }, completion: nil)
        }
        
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.background.alpha = 0
            self.DestinationViewController.view.removeFromSuperview()
        }
        self.mapView.removeAnnotation(currentAnnotation)
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
    
    let DestinationViewController = AddDestinationViewController()

    func showPopUp() {
        //let DestinationViewController = AddDestinationViewController()
        addChild(DestinationViewController)
        view.addSubview(DestinationViewController.view)
        DestinationViewController.didMove(toParent: self)
        
        DestinationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        DestinationViewController.view.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: DestinationViewController.view.trailingAnchor, multiplier: 1).isActive = true
        
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: DestinationViewController.view.bottomAnchor, multiplier: 3).isActive = true
    }
    
    

}

