//
//  LocationSearchTable.swift
//  TSPappV3
//
//  Created by Adnan Shoukfeh on 12/24/19.
//  Copyright © 2019 Adnan Shoukfeh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?
    
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        //put space between number and street
        let firstSpace = (selectedItem.subThoroughfare != nil
            && selectedItem.thoroughfare != nil) ? " " : ""
        
        //put comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil
            || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil
                || selectedItem.administrativeArea != nil) ? ", " : ""
        
        //put space between city and state
        let secondSpace = (selectedItem.subAdministrativeArea != nil
            && selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            //street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            //street name
            selectedItem.thoroughfare ?? "",
            comma,
            //city
            selectedItem.locality ?? "",
            secondSpace,
            //state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //IMPLEMENT LATER
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else {
                return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        
    }
} //extension


extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        //cell.detailTextLabel?.text = ""
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        
        return cell
    }
}
