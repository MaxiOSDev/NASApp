//
//  GalleryController.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class GalleryController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var pageNumberDelegate: PageNumberDelegate?
    let client = NASAClient()
   // var nasaGallery = [NASAGallery]()
    
    var galleryImage: NASAGalleryLinks? {
        
        didSet {
            dataSource.update(with: (galleryImage?.links)!)
            collectionView.reloadData()
        }
    }
    
    var galleryLinks: NASAGalleryCollection? {
        didSet {
            dataSource.updateArray(with: (galleryLinks?.collection.items)!)
            collectionView.reloadData()
        }
    }
    
    lazy var dataSource: GalleryDatasource = {
        return GalleryDatasource(images: [], links: [], collectionView: collectionView)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        client.parseCollection(from: .gallery) { result in
            switch result {
                
            case .success(let collectionResult):
                guard var collectionResults = collectionResult else { return }
                
                print(collectionResults.collection.items.count)
                var linkArray = [NASAGalleryLinks]()
                
                for link in collectionResults.collection.items {
                    for href in link.links {
                        if href.href?.range(of: ".jpg") != nil {
                            linkArray.append(link)
                            print("Yes \(href.href)\n")
                        } else {
                            print("No \(href.href)\n")
                        }
                    }
                }

                for link in collectionResults.collection.links {
                    if link.prompt == "Next" {
                        if let number = Int(link.href.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                           // self.pageNumberDelegate?.getPageNumber(number)
                            self.dataSource.pageNumber = number
                        }
                    }
                }
                
                collectionResults.collection.items.removeAll()
                collectionResults.collection.items = linkArray
                self.galleryLinks = collectionResults
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error for results data \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell), let pageViewController = segue.destination as? GalleryPageController {
//                for galleryLink in dataSource.links {
//                    pageViewController.photoLinks = galleryLink.links
//                }
                
                pageViewController.photoLinks = (galleryLinks?.collection.items)!
                pageViewController.indexOfCurrentPhoto = indexPath.row
                for (index, element) in dataSource.downloadedImages.enumerated() {
                    print("Item \(index): \(element)")
                    if indexPath.row == index {
                        pageViewController.image = element
                    }
                }
            }
        }
    }
}















