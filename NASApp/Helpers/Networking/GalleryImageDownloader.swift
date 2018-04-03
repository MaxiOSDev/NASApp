//
//  GalleryImageDownloader.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

class GalleryDownloader: Operation {
    var galleryImage: NASAGallery
    
    init(image: NASAGallery) {
        self.galleryImage = image
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        if let imagePath = galleryImage.href {
            if let url = URL(string: imagePath) {
                let imageData = try? Data(contentsOf: url)
                if self.isCancelled {
                    return
                }
                
                if let data = imageData, data.count > 0 {
                    let image = UIImage(data: data)
                    if let image = image {
                      ImageCache.shared.add(with: imagePath, image: image)
                        
                    }
                    
                } else {
                    print("failed")
                }
            }

        }

    }
}
