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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addTextField(_ sender: UIButton) {
        createTextField()
        
    }
    
    
    // For tommorow, can use a textfield or differnt of some sorts like apple or snapchat does. The CG Point can be a place where the user drags the label/text around. Pan Drag gesture to drag the text label from one place to another. Then get those CGPoint coords and pass it in. The text will be the labels text, and the image is the imageview.image.
    // FIXME: - MORE IMPLEMENTATION
    
    // MARK: - Helper Methods
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
    
    func createTextField() {
        
        let newTextfield = UITextField(frame: CGRect(x: view.center.x, y: view.center.y, width: 50, height: 80))
        newTextfield.attributedPlaceholder = NSAttributedString(string: "Text", attributes: [NSAttributedStringKey.foregroundColor: UIColor.blue])
        newTextfield.font = UIFont.systemFont(ofSize: 20)
        newTextfield.borderStyle = UITextBorderStyle.none
        newTextfield.textColor = .blue
        newTextfield.autocorrectionType = UITextAutocorrectionType.no
        newTextfield.keyboardType = .default
        newTextfield.returnKeyType = UIReturnKeyType.done
        newTextfield.clearButtonMode = UITextFieldViewMode.whileEditing
        newTextfield.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        newTextfield.delegate = self
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleDrag(_:)))
        dragGesture.delegate = self
        newTextfield.addGestureRecognizer(dragGesture)
        newTextfield.isUserInteractionEnabled = true
        self.view.addSubview(newTextfield)
    }
    
    
    @objc func handleDrag(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(.zero, in: self.view)
    }

}

extension EditImageController: UITextFieldDelegate, UIGestureRecognizerDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing
        print("Textfield should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        print("\(textField.frame.size.width)")
        return true
    }
}













