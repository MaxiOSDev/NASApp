//
//  APIClient.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

protocol APIClientProtocol {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClientProtocol {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        var alertController = UIAlertController(title: "Something went wrong", message: "Please wait and try again", preferredStyle: .alert)
        alertController.addAction(action)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {

                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        
                        completion(genericModel, nil)
                    } catch {
                      //  print(error)
                        alertController.title = APIError.jsonConversionFailure.localizedDescription
                        alertController.presentInOwnWindow(animated: true, completion: nil)
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    alertController.title = APIError.invalidData.localizedDescription
                    alertController.presentInOwnWindow(animated: true, completion: nil)
                    completion(nil, .invalidData)
                }
            } else {
                alertController.title = "Error with status code: \(httpResponse.statusCode)"
                alertController.presentInOwnWindow(animated: true, completion: nil)
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
    }
    
}
