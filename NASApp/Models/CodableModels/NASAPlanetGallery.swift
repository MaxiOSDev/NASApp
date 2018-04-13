//
//  NASAPlanetGallery.swift
//  NASApp
//
//  Created by Max Ramirez on 4/13/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

class PlanetGalleryData {
    static var sharedInstance = PlanetGalleryData()
    var planet: String?
}

struct NASAPlanetCollection: Codable {
    var collection: Collection
    struct Collection: Codable {
        var href: String
        var items: [NASAGalleryLinks]
    }
}
