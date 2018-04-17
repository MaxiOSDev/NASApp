//
//  PlanetGalleryController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/13/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class PlanetGalleryController: UICollectionViewController {
    var images = [NASAGallery]()
    var links = [NASAGalleryLinks]()
    let nukeManager = Nuke.Manager.shared
    var photos = [URL]()
    
    var chosenPlanet: String? {
        didSet {
            navigationItem.title = chosenPlanet
        }
    }

    var galleryImage: NASAGalleryLinks? {
        didSet {
            update(with: (galleryImage?.links)!)
            collectionView?.reloadData()
        }
    }
    
    var galleryLinks: NASAPlanetCollection? {
        didSet {
            updateArray(with: (galleryLinks?.collection.items)!)
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return links.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetGalleryCell", for: indexPath) as! PlanetGalleryCell
        let image = links[indexPath.row]
        for gallery in image.links {
            photos.append(URL(string: gallery.href!)!)
            
            for data in image.data {
                print(data)
                
                cell.imageTitleLabel.text = data.title
                
            }
        }
        
        var newArray = photos.removingDuplicates()
        
        let request = makeRequest(with: newArray[indexPath.row])
        nukeManager.loadImage(with: request, into: cell.imageView)
    
        return cell
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

extension PlanetGalleryController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView?.indexPath(for: cell), let pageViewController = segue.destination as? PlanetGalleryPageController {
                
                pageViewController.photoLinks = links
                pageViewController.indexOfCurrentPhoto = indexPath.row
            }
    }
}












