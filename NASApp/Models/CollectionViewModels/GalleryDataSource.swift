//
//  GalleryDataSource.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class GalleryDatasource: NSObject, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView
    private var images: [NASAGallery]
    var links: [NASAGalleryLinks]
    let client = NASAClient()
    let nukeManager = Nuke.Manager.shared
    var pageNumber: Int?
    var photos = [URL]()
    
    init(images: [NASAGallery], links: [NASAGalleryLinks], collectionView: UICollectionView) {
        self.images = images
        self.collectionView = collectionView
        self.links = links
        super.init()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! NASAGalleryCell
        
        let image = links[indexPath.row]
        
        for gallery in image.links {
            photos.append(URL(string: gallery.href!)!)

            for data in image.data {
                galleryCell.imageNameLabel.text = data.title
                galleryCell.imageDetailLabel.text = data.secondaryCreator
            }
        }
        
        if indexPath.row != 0 {
            galleryCell.planetLogoImageView.isHidden = true
            galleryCell.nasaGalleriesLabel.isHidden = true
        }
        var newArray = photos.removingDuplicates()
        
        let request = makeRequest(with: newArray[indexPath.row])
        nukeManager.loadImage(with: request, into: galleryCell.galleryImageView)
        
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
    
    func makeRequest(with url: URL) -> Request {
        return Request(url: url)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == links.count - 2 {
            if let number = pageNumber {
                client.parsePagedCollectionWithPageNumber(number) { result in
                    switch result {
                    case .success(let galleryResults):
                        guard let galleryResult = galleryResults else { return }
                        var linkArray = [NASAGalleryLinks]()
                        
                        for link in galleryResult.collection.items {
                            for href in link.links {
                                let hrefString = String(describing: href.href)
                                if hrefString.range(of: ".jpg") != nil {
                                    linkArray.append(link)
                                }
                            }
                        }
                        
                        for link in galleryResult.collection.links {
                            if link.prompt == "Next" {
                                if let number = Int(link.href.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                    self.pageNumber = number
                                }
                            }
                        }
                        
                        self.links.append(contentsOf: linkArray)
                        collectionView.reloadData()
                    case .failure(let error):
                        print("Encountered error: \(error)")
                        let alertController = UIAlertController(title: "Encountered Error: \(error.localizedDescription)", message: "Please wait and try again", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                        alertController.addAction(action)
                        alertController.presentInOwnWindow(animated: true, completion: nil)
                    }
                }
            }
        }
    }

}

extension GalleryDatasource: PageNumberDelegate {
    func getPageNumber(_ number: Int?) {
        pageNumber = number
    }
}








































