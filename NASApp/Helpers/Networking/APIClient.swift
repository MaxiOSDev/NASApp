//
//  APIClient.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

class NASAClient: APIClientProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func parseCollection(from galleryFeedType: NASADetail, completion: @escaping (Result<NASAGalleryCollection?, APIError>) -> Void) {
        let endpoint = galleryFeedType
      //  print("Endpoint: \(endpoint.path) query Items: \(endpoint.queryItems)")
        let request = endpoint.request
     //  print("Request: \(request)")
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> NASAGalleryCollection? in
        //        print("JSON \(json)")
                guard let galleryFeedResult = json as? NASAGalleryCollection else {
                    return nil
                }
                
            //    print(galleryFeedResult)
                
                return galleryFeedResult
            }, completion: completion)
        }
    }
    
    func parsePagedCollectionWithPageNumber(_ number: Int, completion: @escaping (Result<NASAGalleryCollection?, APIError>) -> Void) {
        let url = URL(string: "https://images-api.nasa.gov/search?center=jpl&page=\(number)")
        let request = URLRequest(url: url!)
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> NASAGalleryCollection? in
         //       print("JSON \(json)")
                guard let galleryFeedResult = json as? NASAGalleryCollection else {
                    return nil
                }
                
                return galleryFeedResult
            }, completion: completion)
        }
    }
    
    func parseRoverCollection(from feedType: NASADetail, completion: @escaping (Result<Welcome?, APIError>) -> Void) {
        let endpoint = feedType
      //  print("Endpoint: \(endpoint.roverPath) queryItems: \(endpoint.roverQueryItems)")
        let request = endpoint.roverRequest
       // print("Rover Request: \(request)")
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> Welcome? in
                guard let roverFeedResult = json as? Welcome else { return nil}
                return roverFeedResult
            }, completion: completion)
        }
    }
    
    func parseEarthImagery(from feedType: NASADetail, completion: @escaping (Result<NASAEarthImagery?, APIError>) -> Void) {
        let endpoint = feedType
        let request = endpoint.earthRequest
        
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> NASAEarthImagery? in
                guard let earthImageryResult = json as? NASAEarthImagery else { return nil }
                return earthImageryResult
            }, completion: completion)
        }
    }
    
    func parsePlanetGallery(from feedType: NASADetail, completion: @escaping (Result<NASAPlanetCollection?, APIError>) -> Void) {
        let endpoint = feedType
        let request = endpoint.planetGalleryRequest
        
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> NASAPlanetCollection? in
                guard let planetGalleryFeedResult = json as? NASAPlanetCollection else { return nil }
                return planetGalleryFeedResult
            }, completion: completion)
        }
    }

}










