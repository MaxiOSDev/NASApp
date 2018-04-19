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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client.parseCollection(from: .gallery) { result in
            switch result {
                
            case .success(let collectionResult):
                guard var collectionResults = collectionResult else { return }
                
                print(collectionResults.collection.items.count)
                var linkArray = [NASAGalleryLinks]()
                
                for link in collectionResults.collection.items {
                    for href in link.links {
                        let hrefString = String(describing: href.href)
                        if hrefString.range(of: ".jpg") != nil {
                            linkArray.append(link)
                        }
                    }
                }
                
                for link in collectionResults.collection.links {
                    if link.prompt == "Next" {
                        if let number = Int(link.href.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
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
                let alertController = UIAlertController(title: "Encountered Error: \(error.localizedDescription)", message: "Please wait and try again", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }
        }
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
                
                pageViewController.photoLinks =  dataSource.links //(galleryLinks?.collection.items)!
                pageViewController.indexOfCurrentPhoto = indexPath.row
            }
        }
    }
}















