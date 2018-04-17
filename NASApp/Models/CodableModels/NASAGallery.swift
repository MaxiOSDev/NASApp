//
//  NASAGallery.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

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

struct NASAGalleryLinks: Codable, Hashable {
    
    var hashValue: Int {
        return links.count.hashValue + data.count.hashValue
    }
    
    static func ==(lhs: NASAGalleryLinks, rhs: NASAGalleryLinks) -> Bool {
        return (lhs.data == rhs.data && lhs.links == rhs.links)
    }

    var links: [NASAGallery]
    var data: [NASAGalleryData]
    private enum CodingKeys: String, CodingKey {
        case links
        case data
    }
}

struct NASAGalleryData: Equatable {
    static func ==(lhs: NASAGalleryData, rhs: NASAGalleryData) -> Bool {
        return lhs.photographer == rhs.photographer && lhs.secondaryCreator == rhs.secondaryCreator && lhs.description == rhs.description && lhs.title == rhs.title
    }
    var description: String?
    var photographer: String?
    var secondaryCreator: String?
    
    var title: String?

   private enum CodingKeys: String, CodingKey {
        case photographer = "photographer"
        case description
        case secondaryCreator = "secondary_creator"
    
        case title

    }
}

extension NASAGalleryData: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photographer = try values.decodeIfPresent(String.self, forKey: .photographer)
        secondaryCreator = try values.decodeIfPresent(String.self, forKey: .secondaryCreator)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

extension NASAGalleryData: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(photographer, forKey: .photographer)
        try container.encode(secondaryCreator, forKey: .secondaryCreator)
        try container.encode(description, forKey: .description)
        try container.encode(title, forKey: .title)
    }
}

struct NASAGallery: Equatable {
    static func ==(lhs: NASAGallery, rhs: NASAGallery) -> Bool {
        return lhs.data == rhs.data && lhs.image == rhs.image && lhs.href == rhs.href
    }
    
    var href: String?
    var image: UIImage?
    var data: NASAGalleryData?
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




































