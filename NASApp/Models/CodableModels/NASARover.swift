//
//  NASARover.swift
//  NASApp
//
//  Created by Max Ramirez on 4/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

struct Photo: Codable, Hashable {
    var hashValue: Int {
        return id.hashValue + sol.hashValue
    }
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.sol == rhs.sol && lhs.imgSrc == rhs.imgSrc && lhs.earthDate == rhs.earthDate
    }
    
    let id: Int
    let sol: Int
    let camera: PhotoCamera
    let imgSrc: String // The image string;
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sol = "sol"
        case camera = "camera"
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover = "rover"
    }
}

struct PhotoCamera: Codable {
    let id: Int
   // let name: PurpleName
    let roverID: Int
  //  let fullName: PurpleFullName
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
       //  case name = "name"
        case roverID = "rover_id"
    //    case fullName = "full_name"
    }
}

//enum PurpleFullName: String, Codable {
//    case frontHazardAvoidanceCamera = "Front Hazard Avoidance Camera"
//    case mastCamera = "Mast Camera"
//    case rearHazardAvoidanceCamera = "Rear Hazard Avoidance Camera"
//}

//enum PurpleName: String, Codable {
//    case fhaz = "FHAZ"
//    case mast = "MAST"
//    case rhaz = "RHAZ"
//}

struct Rover: Codable {
    let id: Int
    let name: RoverName
    let landingDate: String
    let launchDate: String
    let status: Status
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [CameraElement]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status = "status"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras = "cameras"
    }
}

struct CameraElement: Codable {
    let name: FluffyName
    let fullName: FluffyFullName
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
    }
}

enum FluffyFullName: String, Codable {
    case chemistryAndCameraComplex = "Chemistry and Camera Complex"
    case frontHazardAvoidanceCamera = "Front Hazard Avoidance Camera"
    case marsDescentImager = "Mars Descent Imager"
    case marsHandLensImager = "Mars Hand Lens Imager"
    case mastCamera = "Mast Camera"
    case navigationCamera = "Navigation Camera"
    case rearHazardAvoidanceCamera = "Rear Hazard Avoidance Camera"
}

enum FluffyName: String, Codable {
    case chemcam = "CHEMCAM"
    case fhaz = "FHAZ"
    case mahli = "MAHLI"
    case mardi = "MARDI"
    case mast = "MAST"
    case navcam = "NAVCAM"
    case rhaz = "RHAZ"
}

enum RoverName: String, Codable {
    case curiosity = "Curiosity"
}

enum Status: String, Codable {
    case active = "active"
}





































