//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import XCTest
import MapKit
@testable import NASApp

class NASAppTests: XCTestCase {
    // API Client
    let client = NASAClient()
    // Stored array properties to hold the parsed data

    var mockEarthImagery = EarthImageryData.sharedInstance //MockEarthImagery.sharedInstance
    
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    let mapView = MKMapView(frame: .zero)
    
    lazy var earthSearchDataSource: EarthSearchDatasource = {
       return EarthSearchDatasource(tableView: tableView, searchController: searchController, mapView: mapView, container: nil)
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    
    }
    
    // Testing Parse of GalleryFeature
    func testGalleryJSONFetch() {
        fetchGalleryCollection()
    }
    
    // Gallery Test Helper
    func fetchGalleryCollection() {
        var galleryCollectionData = [NASAGalleryLinks]()
        XCTAssert(galleryCollectionData.count == 0, "Gallery Collection Array is not equal to 0")
        client.parseCollection(from: .gallery) { result in
            switch result {
            case .success(let galleryCollectionResult):
                print("HITTTT")
                guard let galleryCollectionResults = galleryCollectionResult else { print("Gallery else clause hit")
                    return }
                galleryCollectionData = galleryCollectionResults.collection.items
                print("Here 4: \(galleryCollectionData.count)")
                XCTAssert(galleryCollectionData.count > 0, "Gallery Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
        print("HIT 2 \(galleryCollectionData.count)")
        
    }
    
    // Testing parse of all Rovers Endpoints
    func testMarsRoversJSONFetch() {
        
        
        
        fetchCuritosityCollection()
        fetchOpportunityCollection()
        fetchSpiritCollection()
        
        
        
    }
    
    // Curiosity Test Helper
    func fetchCuritosityCollection() {
        var curiosityCollectionData = [Photo]()
        XCTAssert(curiosityCollectionData.count == 0, "Curiosity Collection Array count is not 0")
        client.parseRoverCollection(from: .curiosity) { result in
            switch result {
            case .success(let curiosityCollection):
                guard let curiosityCollectionResults = curiosityCollection else { print("Curiosity Else Clause")
                    return }
                curiosityCollectionData = curiosityCollectionResults.photos
                XCTAssert(curiosityCollectionData.count > 0, "Curiosity Collection Array is 0")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    // Opportunity Test Helper
    func fetchOpportunityCollection() {
        var opportunityCollectionData = [Photo]()
        XCTAssert(opportunityCollectionData.count == 0, "Opportunity Collection Array count is not 0")
        client.parseRoverCollection(from: .opportunity) { result in
            switch result {
            case .success(let opportunityCollection):
                guard let opportunityCollectionResults = opportunityCollection else { print("Curiosity Else Clause")
                    return }
                opportunityCollectionData = opportunityCollectionResults.photos
                XCTAssert(opportunityCollectionData.count > 0, "Opportunity Collection Array count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    // Spirit Test Helper
    func fetchSpiritCollection() {
        var spiritCollectionData = [Photo]()
        XCTAssert(spiritCollectionData.count == 0, "Spirit Collection Array count is not 0")
        client.parseRoverCollection(from: .spirit) { result in
            switch result {
            case .success(let spiritCollection):
                guard let spiritCollectionResults = spiritCollection else { print("Curiosity Else Clause")
                    return }
                spiritCollectionData = spiritCollectionResults.photos
                XCTAssert(spiritCollectionData.count > 0, "Spirit Collection Array count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func testEarthImagery() {
        fetchEarthImageryData()
    }
    
    // Earth Imagery Test Helper
    func fetchEarthImageryData() {
        let newClient = MockEarthImageryClient()
        let longitude: CLLocationDegrees = 0.1340118
        let latitude: CLLocationDegrees = 51.5097724
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        var locationName: String = ""
        var locationDate: String = ""
        var locationAddress: String = ""
        var locationUrl: String = ""
        XCTAssert(locationName == "" && locationDate == "" && locationUrl == "" && locationAddress == "", "String is not empty")
        newClient.parseEarthImagery(from: .earthImagery) { result in
            switch result {
            case .success(let earthImageryResults):
                guard let earthImageryResult = earthImageryResults else { return }
                locationName = placemark.name!
                locationDate = earthImageryResult.date
                locationUrl = earthImageryResult.url
                locationAddress = self.earthSearchDataSource.parseAddress(selectedItem: placemark)
                        XCTAssert(locationName == "Savini At Criterion", "Location Name is not correct")
                        XCTAssert(locationDate == "2013-12-24T10:53:50", "Location Date is not correct")
                        XCTAssert(locationUrl == "https://earthengine.googleapis.com/api/thumb?", "Location URL is not correct")
                        XCTAssert(locationAddress == "224 Piccadilly, London England", "Location Address is not correct")

            case .failure(let error):
                print("Error for earth imagery \(error)")
            }
        }
    }
    
    // Earth Imagery Mock Class
    class MockEarthImageryClient: NASAClient {
        override func parseEarthImagery(from feedType: NASADetail, completion: @escaping (Result<NASAEarthImagery?, APIError>) -> Void) {
            // Inserting url with hard-coded lat and lon for testing purposes.
           let url = URL(string: "https://api.nasa.gov/planetary/earth/imagery/?lon=-0.1340118&lat=51.5097724&api_key=FibfgEAUvuS0knr5woA5aNckz4QWk12iB5KHkBKr")
            let request = URLRequest(url: url!)
            DispatchQueue.main.async {
                self.fetch(with: request, decode: { (json) -> NASAEarthImagery? in
                    guard let earthImageryResult = json as? NASAEarthImagery else { return nil }
                    return earthImageryResult
                }, completion: completion)
            }
        }
    }
}











