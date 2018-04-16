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
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    let client = NASAClient()
    var roverImage = [Welcome]()
   // weak var segmentedControlIndexDelegate: SegementIndexDelegate?
//    var roverImage: [Welcome]? {
//        didSet {
//                dataSource.update(with: self.roverImage![0].photos, self.roverImage![1].photos, self.roverImage![2].photos)
//                collectionView.reloadData()
//        }
//    }
    
    lazy var dataSource: RoverDataSource = {
       return RoverDataSource(images: [], collectionView: collectionView)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.segmentedControlIndex = 0
        curiosityParse()
        roverSegmentedControl.selectedSegmentIndex = 0
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
            dataSource.segmentedControlIndex = 0
            collectionView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            print("Opporunity")
            
            dataSource.segmentedControlIndex = 1
            collectionView.reloadData()
        } else if sender.selectedSegmentIndex == 2 {
            print("Spirit")
            
            dataSource.segmentedControlIndex = 2
            collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    func curiosityParse() {
        client.parseRoverCollection(from: .curiosity) { (result) in
            switch result {
            case .success(let collectionResult):
                guard let collectionResults = collectionResult else { return }
                print("Curiosity Count \(collectionResults.photos.count)")
                self.roverImage.append(collectionResult!)
                print("RoverImage Count: \(self.roverImage.count)")

                self.passCuriosityData()
            case .failure(let error):
                print("Error for results data \(error)")
            }
        }
    }
    
    func opportunityParse() {
        client.parseRoverCollection(from: .opportunity) { (result) in
            switch result {
            case .success(let collectionResult):
                guard let collectionResults = collectionResult else { return }
                print("Opportunity Count \(collectionResults.photos.count)")
                self.roverImage.append(collectionResult!) //collectionResults
                print("RoverImage Count: \(self.roverImage.count)")
               self.passOpportunityData()
                
            case .failure(let error):
                print("Error for results data \(error)")
            }
        }
    }
    
    func spiritParse() {
        client.parseRoverCollection(from: .spirit) { (result) in
            switch result {
            case .success(let collectionResult):
                guard let collectionResults = collectionResult else { return }
                print("Spirit Count \(collectionResults.photos.count)")
                self.roverImage.append(collectionResult!) //collectionResults
                print("RoverImage Count: \(self.roverImage.count)")
                self.passSpiritData()
            case .failure(let error):
                print("Error for results data \(error)")
            }
        }
    }
    
    func passCuriosityData() {
        print(roverImage.count)
        let curiosityPhotos: [Photo]? = self.roverImage[0].photos
        dataSource.updateCuriosity(with: curiosityPhotos)
        collectionView.reloadData()
        opportunityParse()
    }
    
    func passOpportunityData() {
        let opporunityPhotos: [Photo]? = self.roverImage[1].photos
        dataSource.updateOpportunity(with: opporunityPhotos)
        collectionView.reloadData()
        spiritParse()
    }
    
    func passSpiritData() {
        let spiritPhotos: [Photo]? = self.roverImage[2].photos
        dataSource.updateSpirit(with: spiritPhotos)
        collectionView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRover" {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell), let navController = segue.destination as? UINavigationController {
                let pageViewController = navController.topViewController as! RoverPageController
                if dataSource.segmentedControlIndex == 0 {
                    pageViewController.photos = dataSource.curiosityImages!
                } else if dataSource.segmentedControlIndex == 1 {
                    pageViewController.photos = dataSource.opporunityImages!
                } else if dataSource.segmentedControlIndex == 2 {
                    pageViewController.photos = dataSource.spiritImages!
                }
               // pageViewController.photos = dataSource.images
                pageViewController.indexOfCurrentPhoto = indexPath.row
            }
        }
    }

}
