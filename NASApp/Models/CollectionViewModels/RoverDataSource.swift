//
//  RoverDataSource.swift
//  NASApp
//
//  Created by Max Ramirez on 4/5/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class RoverDataSource: NSObject, UICollectionViewDataSource {
    private let collectionView: UICollectionView
    var curiosityImages: [Photo]?
    var opporunityImages: [Photo]?
    var spiritImages: [Photo]?
    let client = NASAClient()
    let nukeManager = Nuke.Manager.shared
    
    var curiosityPhotosURL = [URL]()
    var opportunityPhotosURL = [URL]()
    var spiritPhotosURL = [URL]()
    
    var segmentedControlIndex: Int?
    
    var pageNumber: Int?
    
    init(images: [Photo], collectionView: UICollectionView) {
        //self.images = images
        self.collectionView = collectionView
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segmentedControlIndex == 0 {
            if let images = curiosityImages {
                return images.count
            }
           // return (curiosityImages?.count)!
        } else if segmentedControlIndex == 1 {
            if let images = opporunityImages {
                return images.count
            }
          //  return (opporunityImages?.count)!
        } else if segmentedControlIndex == 2 {
            if let images = spiritImages {
                return images.count
            }
          //  return (spiritImages?.count)!
        }
        
        return 0
        
       // return curiosityImages?.count ?? opporunityImages?.count ?? spiritImages?.count ?? 0 //images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let roverCell = collectionView.dequeueReusableCell(withReuseIdentifier: "roverCell", for: indexPath) as! NASARoverCell
        
        if segmentedControlIndex == 0 {
            let image = curiosityImages![indexPath.row]
            let request = makeRequest(with: URL(string: image.imgSrc)!)
            nukeManager.loadImage(with: request, into: roverCell.imageView)
            roverCell.roverSolLabel.text = image.earthDate
            roverCell.imageID.text = "\(image.id)"
        } else if segmentedControlIndex == 1 {
            let image = opporunityImages![indexPath.row]
            let request = makeRequest(with: URL(string: image.imgSrc)!)
            nukeManager.loadImage(with: request, into: roverCell.imageView)
            roverCell.roverSolLabel.text = image.earthDate
            roverCell.imageID.text = "\(image.id)"
        } else {
            let image = spiritImages![indexPath.row]
            let request = makeRequest(with: URL(string: image.imgSrc)!)
            nukeManager.loadImage(with: request, into: roverCell.imageView)
            roverCell.roverSolLabel.text = image.earthDate
            roverCell.imageID.text = "\(image.id)"
        }

        return roverCell
    }
    
    func updateCuriosity(with roverImages: [Photo]?) {
        self.curiosityImages = roverImages
    }
    
    func updateOpportunity(with roverImages: [Photo]?) {
        self.opporunityImages = roverImages
    }
    
    func updateSpirit(with roverImages: [Photo]?) {
        self.spiritImages = roverImages
    }
    
//    func update(with roverImages: [Photo]?, _ opportunityImages: [Photo]?, _ spiritImages: [Photo]?) {
//        self.curiosityImages = roverImages
//        self.opporunityImages = opportunityImages
//        self.spiritImages = spiritImages
//    }
    
    func makeRequest(with url: URL) -> Request {
        return Request(url: url)
    }
}

extension RoverDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        if indexPath.row == 0 {
            return CGSize(width: screenWidth, height: screenWidth/2)
        }
        
        return CGSize(width: screenWidth/2, height: screenWidth/3)
    }
}













