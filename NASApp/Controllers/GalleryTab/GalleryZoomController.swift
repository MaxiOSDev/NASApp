//
//  GalleryZoomController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class GalleryZoomController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    var photo: NASAGalleryLinks!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Photo that is in GalleryZoomController: \(photo)")
        
        // Do any additional setup after loading the view.
        for link in photo.links {
            print("Inside Zoom for loop: \(link.href) \(link.data) \(link.galleryState) \(link.image)")
            photoImageView.image = link.image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var minZoomScale: CGFloat {
        let viewSize = view.bounds.size
        let widthScale = viewSize.width/photoImageView.bounds.width
        let heightScale = viewSize.height/photoImageView.bounds.height
        
        return min(widthScale, heightScale)
    }
    
    func updateZoomScale() {
        
        scrollView.minimumZoomScale = minZoomScale
        scrollView.zoomScale = minZoomScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let verticalSpace = size.height - photoImageView.frame.height
        let yOffSet = max(0, verticalSpace/2)
        imageViewTopConstraint.constant = yOffSet
        imageViewBottomConstraint.constant = yOffSet
        
        let xOffSet = max(0, (size.width - photoImageView.frame.width)/2)
        imageViewLeadingConstraint.constant = xOffSet
        imageViewTrailingConstraint.constant = xOffSet
    }
    

}

extension GalleryZoomController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
        // The following would be used for a modally presented viewController... Instead of dismiss could try an action? Or perhaps something else.
//        if scrollView.zoomScale < minZoomScale {
//            dismiss(animated: true, completion: nil)
//        }
    }
}





