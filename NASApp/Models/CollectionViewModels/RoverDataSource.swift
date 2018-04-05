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
    var images: [Photo]
    let client = NASAClient()
    let nukeManager = Nuke.Manager.shared
    var photosURL = [URL]()
    
    init(images: [Photo], collectionView: UICollectionView) {
        self.images = images
        self.collectionView = collectionView
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let roverCell = collectionView.dequeueReusableCell(withReuseIdentifier: "roverCell", for: indexPath) as! NASARoverCell
        let image = images[indexPath.row]
        
        let request = makeRequest(with: URL(string: image.imgSrc)!)
        nukeManager.loadImage(with: request, into: roverCell.imageView)
        roverCell.roverSolLabel.text = image.earthDate
        
        return roverCell
    }
    
    func update(with roverImages: [Photo]) {
        self.images = roverImages
    }
    
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













