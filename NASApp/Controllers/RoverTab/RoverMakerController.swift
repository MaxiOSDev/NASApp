//
//  RoverMakerController.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class RoverMakerController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roverSegmentedControl: UISegmentedControl!
    let client = NASAClient() 
    var roverImage: Welcome? {
        didSet {
            dataSource.update(with: (roverImage?.photos)!)
            collectionView.reloadData()
        }
    }
    
    lazy var dataSource: RoverDataSource = {
       return RoverDataSource(images: [], collectionView: collectionView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        client.parseRoverCollection(from: .rover) { (result) in
            switch result {
            case .success(let collectionResult):
                guard let collectionResults = collectionResult else { return }
                print(collectionResults.photos.count)
                self.roverImage = collectionResults
            case .failure(let error):
                print("Error for results data \(error)")
                
            }
        }
        
        collectionView.dataSource = dataSource
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
    


    @IBAction func roverSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("Curiosity")
        } else if sender.selectedSegmentIndex == 1 {
            print("Opporunity")
        } else if sender.selectedSegmentIndex == 2 {
            print("Spirit")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRover" {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell), let pageViewController = segue.destination as? RoverPageController {
                pageViewController.photos = dataSource.images
                pageViewController.indexOfCurrentPhoto = indexPath.row
            }
        }
    }

}
