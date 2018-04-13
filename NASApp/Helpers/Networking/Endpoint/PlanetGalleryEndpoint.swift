//
//  PlanetGalleryEndpoint.swift
//  NASApp
//
//  Created by Max Ramirez on 4/13/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

protocol PlanetGalleryEndpoint {
    var planetBase: String { get }
    var planetPath: String { get }
    var planetQueryItems: [URLQueryItem] { get }
}

extension PlanetGalleryEndpoint {
    var planetBase: String {
        return "https://images-api.nasa.gov"
    }
    
    var planetGalleryUrlComponents: URLComponents {
        var components = URLComponents(string: planetBase)!
        components.path = planetPath
        components.queryItems = planetQueryItems
        return components
    }
    
    var planetGalleryRequest: URLRequest {
        let url = planetGalleryUrlComponents.url!
        print("URL in planet gallery : \(url)")
        return URLRequest(url: url)
    }
    
}

extension NASADetail: PlanetGalleryEndpoint {

    var planetPath: String {
        switch self {
        case .gallery, .curiosity, .opportunity, .spirit, .earthImagery: return ""
        case .planetGallery: return  "/search"
        }
    }
    
    var planetQueryItems: [URLQueryItem] {
        var result = [URLQueryItem]()
        let planet = URLQueryItem(name: "q", value: PlanetGalleryData.sharedInstance.planet!)
        result.append(planet)
        return result
    }
}

