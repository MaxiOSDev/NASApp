//
//  GalleryPageController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class GalleryPageController: UIPageViewController {
    
    var photoLinks: [NASAGalleryLinks] = []
    var indexOfCurrentPhoto: Int!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        print("IndexPath: \(indexOfCurrentPhoto)")
        
        if let photoViewerController = photoViewerController(with: photoLinks[indexOfCurrentPhoto]) {
            setViewControllers([photoViewerController], direction: .forward, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func photoViewerController(with galleryPhoto: NASAGalleryLinks) -> GalleryZoomController? {
        guard let storyboard = storyboard, let zoomViewerController = storyboard.instantiateViewController(withIdentifier: "GalleryZoomController") as? GalleryZoomController else { return nil }
        zoomViewerController.photo = galleryPhoto

        return zoomViewerController
    }

}

extension GalleryPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       guard let zoomVC = viewController as? GalleryZoomController, let index = photoLinks.index(of: zoomVC.photo) else { return nil }
        if index == photoLinks.startIndex {
            return nil
        } else {
            let indexBefore = photoLinks.index(before: index)
            let photo = photoLinks[indexBefore]
            return photoViewerController(with: photo)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let zoomVC = viewController as? GalleryZoomController, let index = photoLinks.index(of: zoomVC.photo) else { return nil }
        if index == photoLinks.index(before: photoLinks.endIndex) {
            return nil
        } else {
            let indexAfter = photoLinks.index(after: index)
            let photo = photoLinks[indexAfter]
            return photoViewerController(with: photo)
        }
    }
    
}
