//
//  LocationMapAnnotationView.swift
//  NASApp
//
//  Created by Max Ramirez on 4/10/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import MapKit

class LocationMapAnnotationView: MKAnnotationView {
    weak var customCalloutView: LocationAnnotatonView?
   
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.customCalloutView?.removeFromSuperview()
            if let newCustomCalloutView = loadLocationMapView() {
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height
                
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: 0.300, animations: {
                        self.customCalloutView?.alpha = 1.0
                    })
                }
            }
            
        } else {
            if customCalloutView != nil {
                if animated { // fade out animation, then remove it.
                    UIView.animate(withDuration: 0.300, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() } // just remove it.
            }
        }
    }
    
    func loadLocationMapView() -> LocationAnnotatonView? {
        if let views = Bundle.main.loadNibNamed("LocationAnnotationView", owner: self, options: nil) as? [LocationAnnotatonView], views.count > 0 {
            let locationAnnotationView = views.first!
            if let locationAnnotation = annotation as? LocationAnnotation {
                let location = locationAnnotation.locationManager
                locationAnnotationView.configureWithImagery(location)
            }
            
            return locationAnnotationView
        }
        
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
}

class LocationAnnotation: NSObject, MKAnnotation {
    var locationManager = EarthImageryData.sharedInstance
    var coordinate: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: locationManager.lat!, longitude: locationManager.lon!)}
}






































