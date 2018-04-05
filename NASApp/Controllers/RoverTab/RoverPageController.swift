//
//  RoverPageController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/5/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class RoverPageController: UIPageViewController {
    
    var photos: [Photo] = []
    var indexOfCurrentPhoto: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let photoViewerController = photoViewerController(with: photos[indexOfCurrentPhoto]) {
            setViewControllers([photoViewerController], direction: .forward, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func photoViewerController(with photo: Photo) -> RoverViewerController? {
        guard let storyboard = storyboard, let photoViewerController = storyboard.instantiateViewController(withIdentifier: "RoverViewerController") as? RoverViewerController else { return nil}
        
        photoViewerController.photo = photo
        return photoViewerController
    }

}

extension RoverPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let photoVC = viewController as? RoverViewerController, let index = photos.index(of: photoVC.photo!) else { return nil }
        
        if index == photos.startIndex {
            return nil
        } else {
            let indexBefore = photos.index(before: index)
            let photo = photos[indexBefore]
            return photoViewerController(with: photo)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let photoVC = viewController as? RoverViewerController, let index = photos.index(of: photoVC.photo!) else { return nil }
        
        if index == photos.index(before: photos.endIndex) {
            return nil
        } else {
            let indexAfter = photos.index(after: index)
            let photo = photos[indexAfter]
            return photoViewerController(with: photo)
        }
    }
}






















