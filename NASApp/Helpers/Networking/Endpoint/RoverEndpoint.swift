//
//  RoverEndpoint.swift
//  NASApp
//
//  Created by Max Ramirez on 4/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

protocol RoverEndpoint {
    var roverBase: String { get }
    var roverPath: String { get }
    var roverQueryItems: [URLQueryItem] { get }
}

extension RoverEndpoint {
    var roverBase: String {
        return "https://api.nasa.gov"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: roverBase)!
        components.path = roverPath
        components.queryItems = roverQueryItems
       // print("Gallery Query Items \(roverQueryItems)")
        return components
    }
    
    var roverRequest: URLRequest {
        let url = urlComponents.url!
        print("URL within RoverEndpoint: \(url)")
        return URLRequest(url: url)
    }
}

extension NASADetail: RoverEndpoint {
    var roverPath: String {
        switch self {
        case .gallery: return ""
        case .curiosity: return "/mars-photos/api/v1/rovers/curiosity/photos"
        case .opportunity: return "/mars-photos/api/v1/rovers/opportunity/photos"
        case .spirit: return "/mars-photos/api/v1/rovers/spirit/photos"
        }
    }
    
    var roverQueryItems: [URLQueryItem] {
        var result = [URLQueryItem]()
        let sol = URLQueryItem(name: "sol", value: "10")
        let API_KEY = URLQueryItem(name: "api_key", value: "FibfgEAUvuS0knr5woA5aNckz4QWk12iB5KHkBKr")
        //let page = URLQueryItem(name: "page", value: "1")
        result.append(sol)
        result.append(API_KEY)
        //result.append(page)
        return result
    }
}





































