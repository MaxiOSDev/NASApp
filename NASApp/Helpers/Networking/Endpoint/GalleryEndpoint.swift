//
//  GalleryEndpoint.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

protocol GalleryEndpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension GalleryEndpoint {
    var base: String {
        return "https://images-api.nasa.gov"
    }
    
    var search: String {
        return "search"
    }
    
    var center: String {
        return "center"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
    //    print("Gallery Query Items \(queryItems)")
        return components
    }
    
    
    var request: URLRequest {
        let url = urlComponents.url!
      //  print("URL within GalleryEndpoint: \(url)")
        return URLRequest(url: url)
    }
}

enum NASADetail {
    case gallery
    case curiosity
    case opportunity
    case spirit
    
}

extension NASADetail: GalleryEndpoint {
    var path: String {
        switch self {
        case .gallery: return "/search"
        case .curiosity, .opportunity, .spirit: return ""
        }
    }
    
    var queryItems: [URLQueryItem] {
        var result = [URLQueryItem]()
        let center = URLQueryItem(name: "center", value: "jpl")
        //let page = URLQueryItem(name: "page", value: "1")
        result.append(center)
        //result.append(page)
        return result
    }
}






