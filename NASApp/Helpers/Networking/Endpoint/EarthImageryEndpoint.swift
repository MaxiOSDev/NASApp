//
//  EarthImageryEndpoint.swift
//  NASApp
//
//  Created by Max Ramirez on 4/9/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

protocol EarthImageryEndpoint {
    var earthBase: String { get }
    var earthPath: String { get }
    var earthQueryItems: [URLQueryItem] { get }
}

extension EarthImageryEndpoint {
    var earthBase: String {
        return "https://api.nasa.gov"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: earthBase)!
        components.path = earthPath
        components.queryItems = earthQueryItems
        return components
    }
    
    var earthRequest: URLRequest {
        let url = urlComponents.url!
        print("URL within EarthEndpoint: \(url)")
        return URLRequest(url: url)
    }
}

extension NASADetail: EarthImageryEndpoint {
    var earthPath: String {
        switch self {
            case .gallery, .curiosity, .opportunity, .spirit: return ""
        case .earthImagery: return "/planetary/earth/imagery/"
        }
    }
    
    var earthQueryItems: [URLQueryItem] {
        var result = [URLQueryItem]()
        let lon = URLQueryItem(name: "lon", value: "\(EarthImageryData.sharedInstance.lon!)")
        let lat = URLQueryItem(name: "lat", value: "\(EarthImageryData.sharedInstance.lat!)")
        let apiKey = URLQueryItem(name: "api_key", value: "FibfgEAUvuS0knr5woA5aNckz4QWk12iB5KHkBKr")
        result.append(lon)
        result.append(lat)
        result.append(apiKey)
        return result
    }
}

















































