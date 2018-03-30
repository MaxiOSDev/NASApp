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
    private var images: [NASAGallery]
    private var links: [NASAGalleryLinks]
    let pendingOperations = PendingOperations()
    
    init(images: [NASAGallery], links: [NASAGalleryLinks], collectionView: UICollectionView) {
        self.images = images
        self.collectionView = collectionView
        self.links = links
        super.init()
    }
    
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Downloader Queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return links.count //images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! NASAGalleryCell
        
     //   let image = images[indexPath.row]
        let image = links[indexPath.row]
        
        for gallery in image.links {
            for data in image.data {
             let viewModel = GalleryCellViewModel(link: image, gallery: gallery , data: data) //GalleryCellViewModel(image: image)
                galleryCell.configure(with: viewModel)
                galleryCell.configureImageDownloader(for: gallery)
            }
        }
        
        

        
        if indexPath.row != 0 {
            galleryCell.planetLogoImageView.isHidden = true
            galleryCell.nasaGalleriesLabel.isHidden = true
        }
        
        if let downloader = galleryCell.imageDownloader {
            downloadQueue.addOperation(downloader)
        }
        
        return galleryCell
    }
    
    func image(at indexPath: IndexPath) -> NASAGallery {
        return images[indexPath.row]
    }
    
    func update(with images: [NASAGallery]) {

        self.images = images
    }
    
    func updateArray(with links: [NASAGalleryLinks]) {
        self.links = links
    }
    
    func downloaderImageForGalleryImage(_ image: NASAGallery, atIndexPAth indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = GalleryDownloader(image: image)
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    func loadGalleryImages() {
        DispatchQueue.global().async {
            NASAClient.loadImagesAsync(from: nil, completion: { (results) in
                self.images = results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
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








































