//
//  APIError.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
enum APIError: Error {
    case jsonParsingFailure
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case unAuthorized
    
    var localizedDescription: String {
        switch self {
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .requestFailed: return "Request Failed"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessfull"
        case .unAuthorized: return "Unauthoried"
        }
    }
}
