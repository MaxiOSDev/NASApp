//
//  EarthSearchDatasource.swift
//  NASApp
//
//  Created by Max Ramirez on 4/9/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import UIKit
import MapKit
import CoreLocation

class EarthSearchDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView
    private let searchController: UISearchController
    var mapView: MKMapView? = nil
    var matchingItems: [MKMapItem] = []
    var mapContainer: UIView?
    var selectedPin: MKPlacemark? = nil
    var mapViewDelegate: MapViewDelegate?
    var searchMode: Bool? = false
    
    init(tableView: UITableView, searchController: UISearchController, mapView: MKMapView, container: UIView?) {
        self.tableView = tableView
        self.searchController = searchController
        self.mapView = mapView
        self.mapContainer = container
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        if matchingItems.count > 0 {
            let item = matchingItems[indexPath.row].placemark
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = parseAddress(selectedItem: item)
        }
        
        return cell
    }
    
    func parseAddress(selectedItem: MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }

}

extension EarthSearchDatasource: MKMapViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView else { return }
        guard let searchBarText = searchController.searchBar.text else { return }
        if searchBarText != "" {
            searchMode = true
            self.mapViewDelegate?.hideMap()
        } else {
            searchMode = false
        }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start() { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            
            self.tableView.reloadData()
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("Cancelled Pressed")
        self.mapViewDelegate?.hideMap()
    }
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark
        guard let mapView = mapView else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality, let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.003, 0.003) // The region
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let container = mapContainer {
            mapViewDelegate?.showMap(for: container)
        }
        
        if matchingItems.count > 0 {
            let item = matchingItems[indexPath.row].placemark
            dropPinZoomIn(placemark: item)
            
        }
        
        tableView.reloadData()
    }
    
}























