//
//  EditImageController.swift
//  NASApp
//
//  Created by Max Ramirez on 4/5/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class EditImageController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var photo: Photo!
    var nukeManager = Nuke.Manager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Request(url: URL(string: (photo?.imgSrc)!)!)
        nukeManager.loadImage(with: request, into: imageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For tommorow, can use a textfield or differnt of some sorts like apple or snapchat does. The CG Point can be a place where the user drags the label/text around. Pan Drag gesture to drag the text label from one place to another. Then get those CGPoint coords and pass it in. The text will be the labels text, and the image is the imageview.image.
    // FIXME: - MORE IMPLEMENTATION 
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
