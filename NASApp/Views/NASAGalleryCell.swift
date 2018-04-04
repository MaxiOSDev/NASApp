//
//  NASAGalleryCell.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

struct GalleryCellViewModel {
    let galleryImage: UIImage
    let label: String
    let detailLabel: String
}

extension GalleryCellViewModel {

    init(link: NASAGalleryLinks, gallery: NASAGallery, data: NASAGalleryData) {
        self.galleryImage = gallery.galleryState == .downloaded ? gallery.image! : #imageLiteral(resourceName: "nasaLogo")
        
        self.label = data.photographer ?? ""
        self.detailLabel = data.secondaryCreator ?? ""
    }
}

class NASAGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageDetailLabel: UILabel!
    
    @IBOutlet weak var planetLogoImageView: UIImageView!
    @IBOutlet weak var nasaGalleriesLabel: UILabel!
    
    var images: NASAGallery?
    
    func configure(with viewModel: GalleryCellViewModel) {
        
        imageNameLabel.text = viewModel.label
        imageDetailLabel.text = viewModel.detailLabel
        
    }
}
















