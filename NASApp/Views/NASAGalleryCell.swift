//
//  NASAGalleryCell.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

struct GalleryCellViewModel {
    let galleryImage: UIImage
    let label: String
    let detailLabel: String
}

extension GalleryCellViewModel {
//    init(image: NASAGallery) {
//        self.galleryImage = image.galleryState == .downloaded ? image.image! : #imageLiteral(resourceName: "nasaLogo")
//        self.label = image.data?.photographer ?? ""
//        self.detailLabel = image.data?.secondaryCreator ?? ""
//    }
    
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
    
    var imageDownloader: GalleryDownloader?
    var images: NASAGallery?

    func configure(with viewModel: GalleryCellViewModel) {
        if let imagePath = images?.href {
            if let image = ImageCache.shared.get(with: imagePath) {
                print("cached image loaded")
                
                self.galleryImageView.image = image
                print("Image Here 1: \(image)")
                
            } else {
                configureImageDownloader(for: images!)
            }
        }
        
        imageNameLabel.text = viewModel.label
        imageDetailLabel.text = viewModel.detailLabel
    }
    
    func configureImageDownloader(for image: NASAGallery) {
        let downloader = GalleryDownloader(image: image)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                if let cacheImage = image.href {
                    self.galleryImageView.image = ImageCache.shared.get(with: cacheImage)

                }
            }
        }
        
        self.imageDownloader = downloader
    }
    
}
















