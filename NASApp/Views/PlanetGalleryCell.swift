//
//  PlanetGalleryCell.swift
//  NASApp
//
//  Created by Max Ramirez on 4/13/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

//struct PlanetGalleryCellViewModel {
//    let galleryImage: UIImage
//    let title: String
//}
//
//extension PlanetGalleryCellViewModel {
//    init(link: NASAGalleryLinks, gallery: NASAGallery, data: NASAGalleryData)
//    self.galleryImage = gallery.galleryState == downloaded ? gallery.image! : #imageLiteral(resourceName: "nasaLogo")
//    self.title = data.title ?? ""
//}

class PlanetGalleryCell: UICollectionViewCell {
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
//    func configure(with viewModel: PlanetGalleryCellViewModel) {
//        imageTitleLabel.text = viewModel.title
//    }
}
