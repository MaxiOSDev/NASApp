//
//  RoverViewerController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/5/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class RoverViewerController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var photo: Photo?
    var nukeManager = Nuke.Manager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request = Request(url: URL(string: (photo?.imgSrc)!)!)
        nukeManager.loadImage(with: request, into: imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedImageView(_ sender: UITapGestureRecognizer) {
        print("Tapped Before")
        guard let storyboard = storyboard else { return }
        print("Tapped After")
        let zoomController = storyboard.instantiateViewController(withIdentifier: String(describing: RoverZoomController.self)) as! RoverZoomController
        zoomController.modalTransitionStyle = .crossDissolve
        zoomController.photo = photo
        
        navigationController?.present(zoomController, animated: true, completion: nil)
    }

}
