//
//  NASAGallery.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

enum GalleryImageState {
    case placeholder
    case downloaded
    case failed
}

struct NASAGalleryCollection: Codable {
    var collection: Collection
    struct Collection: Codable {
        var version: String
        var href: String
        var items: [NASAGalleryLinks]
        var links: [CollectionLink]
    }
}

struct CollectionLink: Codable {
    let href: String
    let prompt: String
}

struct NASAGalleryLinks: Codable {

    var links: [NASAGallery]
    var data: [NASAGalleryData]
    private enum CodingKeys: String, CodingKey {
        case links
        case data
    }
}

struct NASAGalleryData {
    var photographer: String?
    var secondaryCreator: String?
    
   private enum CodingKeys: String, CodingKey {
        case photographer = "photographer"
        case secondaryCreator = "secondary_creator"
    }
}


extension NASAGalleryData: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photographer = try values.decodeIfPresent(String.self, forKey: .photographer)
        secondaryCreator = try values.decodeIfPresent(String.self, forKey: .secondaryCreator)
    }
}

extension NASAGalleryData: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(photographer, forKey: .photographer)
        try container.encode(secondaryCreator, forKey: .secondaryCreator)
    }
}

struct NASAGallery {

    var href: String?
    var image: UIImage?
    var data: NASAGalleryData?
    var galleryState = GalleryImageState.placeholder
   private enum CodingKeys: String, CodingKey {
        case href
    }
}

extension NASAGallery: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        href = try values.decode(String.self, forKey: .href)
    }
}

extension NASAGallery: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(href, forKey: .href)
    }
}



































