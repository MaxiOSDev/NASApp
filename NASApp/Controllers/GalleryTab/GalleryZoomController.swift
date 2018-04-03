//
//  GalleryZoomController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class GalleryZoomController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    var photo: NASAGalleryLinks!
    var image: UIImage!
    var nukeManager = Nuke.Manager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Photo that is in GalleryZoomController: \(photo)")
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        // Do any additional setup after loading the view.
        for link in photo.links {
            let request = Request(url: URL(string: link.href!)!)
            nukeManager.loadImage(with: request, into: photoImageView)
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }


}






