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
        print("Endpoint: \(endpoint.path) query Items: \(endpoint.queryItems)")
        let request = endpoint.request
        print("Request: \(request)")
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> NASAGalleryCollection? in
                print("JSON \(json)")
                guard let galleryFeedResult = json as? NASAGalleryCollection else {
                    return nil
                }
                
                print(galleryFeedResult)
                
                return galleryFeedResult
            }, completion: completion)
        }
    }
    
    func parsePagedCollectionWithPageNumber(_ number: Int, completion: @escaping (Result<NASAGalleryCollection?, APIError>) -> Void) {
        let url = URL(string: "https://images-api.nasa.gov/search?center=jpl&page=\(number)")
        let request = URLRequest(url: url!)
        DispatchQueue.main.async {
            self.fetch(with: request, decode: { (json) -> NASAGalleryCollection? in
                print("JSON \(json)")
                guard let galleryFeedResult = json as? NASAGalleryCollection else {
                    return nil
                }
                
                return galleryFeedResult
            }, completion: completion)
        }
    }
    
    static func loadImagesAsync(from feedType: NASADetail?, completion: @escaping ([NASAGallery]) -> Void) {
        URLSession.shared.dataTask(with: (feedType?.request)!) { (data, response, error) in
            let images = [NASAGallery]()
            if let _ = data {
                completion(images)
            }
        } .resume()
    }
}
