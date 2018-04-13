//
//  PlanetImageDetailController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/13/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class PlanetImageDetailController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var photo: NASAGalleryLinks!
    var nukeManager = Nuke.Manager.shared
    var textData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
        for link in photo.links {
            let request = Request(url: URL(string: link.href!)!)
            nukeManager.loadImage(with: request, into: imageView)
        }
        
        textView.text = textData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension PlanetImageDetailController: UITextViewDelegate {
    
}
