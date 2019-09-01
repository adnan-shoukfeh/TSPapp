//
//  ViewController.swift
//  TSPapp
//
//  Created by Adnan Shoukfeh on 8/26/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var addOrCancel = UIStackView()
    var currentAnnotation = MKPointAnnotation()
    
    
    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
    }
    
    //MAYBE DELETE THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    @IBAction func cancelPressed(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds.size

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.addOrCancel.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height * 0.2)
        }, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
    }//searchBarSearchButtonClicked
    
    //declare outside in order to access in several functions
    let mapInBackground = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: 10, height: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let stackView = UIStackView()
    
    func userChoice() {
        //allow user to choose whether to add or cancel
        
        if let window = UIApplication.shared.keyWindow {
            
            mapInBackground.backgroundColor = UIColor(white: 0, alpha: 0.2)
            
            mapInBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(mapInBackground)
            
            //window.addSubview(collectionView)
            window.addSubview(stackView)

            
            //let height: CGFloat = 200
            let height: CGFloat = window.frame.height * 0.22
            let y = window.frame.height - height
            //collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            stackView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            stackView.addBackground(color: .white)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 15
            
            
            mapInBackground.frame = window.frame
            mapInBackground.alpha = 0
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.mapInBackground.alpha = 1
                
                //self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                self.stackView.frame = CGRect(x: 0, y: y, width: self.stackView.frame.width, height: self.stackView.frame.height)
            }, completion: nil)
            
            
        }
    }//userChoice
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.mapInBackground.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                //self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.width)
                self.stackView.frame = CGRect(x: 0, y: window.frame.height, width: self.stackView.frame.width, height: self.stackView.frame.width)
            }
            
        }
        self.mapView.removeAnnotation(currentAnnotation)
    }

    /*
    func arrangeStackView() {
        
        let addButton = UIButton(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        addButton.setTitle("ADD", for: .normal)
        addButton.backgroundColor = UIColor(red: 83, green: 215, blue: 105, alpha: 0)
        addButton.layer.cornerRadius = 10
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.backgroundColor = UIColor(red: 248, green: 73, blue: 76, alpha: 0)
        cancelButton.layer.cornerRadius = 10
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(cancelButton)
        
    }
 */

    
    @IBOutlet weak var mapView: MKMapView!
    //@IBOutlet weak var addButton: UIButton!
    //@IBOutlet weak var cancelButton: UIButton!
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: collectionView.frame.width, height: 50)
        return CGSize(width: 50, height: 50)
        //CHANGE HEIGHT^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //arrangeStackView()
        let addButton = UIButton()
        addButton.setTitle("ADD", for: .normal)
        addButton.backgroundColor = UIColor(red: 83, green: 215, blue: 105, alpha: 0)
        addButton.layer.cornerRadius = 10
        let cancelButton = UIButton()
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.backgroundColor = UIColor(red: 248, green: 73, blue: 76, alpha: 0)
        cancelButton.layer.cornerRadius = 10
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(cancelButton)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(OptionsCell.self, forCellWithReuseIdentifier: cellId)
    }


}

