//
//  PlanetNode.swift
//  NASApp
//
//  Created by Max Ramirez on 4/12/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import SceneKit

class EarthNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "earthmap1k")
        self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
        self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
        self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SunNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sunmap")
      //  self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
      //  self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
     //   self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MercuryNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "mercurymap")
      //  self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
      //  self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
     //   self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class VenusNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "venusmap")
       // self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
      //  self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
       // self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MarsNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "mars_1k_color")
       // self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
       // self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
      //  self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class JupitarNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "jupitermap")
      //  self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
      //  self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
      //  self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SaturnNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "saturnmap")
      //  self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
      //  self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
     //   self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class UranusNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "uranusmap")
      //  self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
      //  self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
      //  self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class NeptuneNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "neptunemap")
       // self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
       // self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
      // self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class PlutoNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "plutomap1k")
       // self.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "earthNormal")
       // self.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
      //  self.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        self.geometry?.firstMaterial?.isDoubleSided = true
        
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}






























