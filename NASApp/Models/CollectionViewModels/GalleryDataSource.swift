//
//  GalleryDataSource.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

class GalleryDatasource: NSObject, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! NASAGalleryCell
        
        if indexPath.row != 0 {
            galleryCell.planetLogoImageView.isHidden = true
            galleryCell.nasaGalleriesLabel.isHidden = true
        }
        
        return galleryCell
    }
    
    
}

extension GalleryDatasource: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        if indexPath.row == 0 {
            return CGSize(width: screenWidth, height: screenWidth/2)
        }
        
        return CGSize(width: screenWidth/2, height: screenWidth/3)
    }

}








































