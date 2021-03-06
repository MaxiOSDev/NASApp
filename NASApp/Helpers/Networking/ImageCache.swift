//
//  ImageCache.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var imageCache = [String: UIImage]()
    private var queue = DispatchQueue(label: "com.ramirezmax.nasapp.imagecache")
    
    func add(with imageName: String, image: UIImage) {
        let workItem = DispatchWorkItem(qos: .default, flags: .barrier) {
            self.imageCache[imageName] = image
            print("Image HERE in chache add: \(image)")
        }
        queue.async(execute: workItem)
    }
    
    func get(with imageName: String) -> UIImage? {
        var image: UIImage? = nil
        queue.sync {
            image = imageCache[imageName]
        }
        return image
    }
    
    func removeAll() {
        imageCache = [:]
    }
}
