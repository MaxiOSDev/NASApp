//
//  ViewController.swift
//  NASApp
//
//  Created by Max Ramirez on 3/29/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

@available(iOS 11.0, *)

class ARPlanetController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let newEarth = EarthNode()
        let position = SCNVector3(0, 0, -0.9)
        newEarth.position = position
        sceneView.scene.rootNode.addChildNode(newEarth)
        segmentedControl.selectedSegmentIndex = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    @IBAction func planetChosen(_ sender: UISegmentedControl) {
        let position = SCNVector3(0, 0, -0.9)
        let newSun = SunNode()
        let newMercury = MercuryNode()
        let newVenus = VenusNode()
        let newEarth = EarthNode()
        let newMars = MarsNode()
        let newJupitar = JupitarNode()
        let newSaturn = SaturnNode()
        let newUranus = UranusNode()
        let newNeptune = NeptuneNode()
        let newPluto = PlutoNode()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        if sender.selectedSegmentIndex == 0 {
            newSun.position = position
            sceneView.scene.rootNode.addChildNode(newSun)
        } else if sender.selectedSegmentIndex == 1 {
            
            newMercury.position = position
            sceneView.scene.rootNode.addChildNode(newMercury)
        } else if sender.selectedSegmentIndex == 2 {
            
            newVenus.position = position
            sceneView.scene.rootNode.addChildNode(newVenus)
        } else if sender.selectedSegmentIndex == 3 {
            
            newEarth.position = position
            sceneView.scene.rootNode.addChildNode(newEarth)
        } else if sender.selectedSegmentIndex == 4 {
            
            newMars.position = position
            sceneView.scene.rootNode.addChildNode(newMars)
        } else if sender.selectedSegmentIndex == 5 {
            
            newJupitar.position = position
            sceneView.scene.rootNode.addChildNode(newJupitar)
        } else if sender.selectedSegmentIndex == 6 {
            
            newSaturn.position = position
            sceneView.scene.rootNode.addChildNode(newSaturn)
        } else if sender.selectedSegmentIndex == 7 {
            
            newUranus.position = position
            sceneView.scene.rootNode.addChildNode(newUranus)
        } else if sender.selectedSegmentIndex == 8 {
            
            newNeptune.position = position
            sceneView.scene.rootNode.addChildNode(newNeptune)
        } else if sender.selectedSegmentIndex == 9 {
            
            newPluto.position = position
            sceneView.scene.rootNode.addChildNode(newPluto)
        }
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        let location = touch?.location(in: sceneView)
//
//        let hitResults = sceneView.hitTest(location!, types: .featurePoint)
//
//        if let hitTestResult = hitResults.first {
//            let transform = hitTestResult.worldTransform
//            let position = SCNVector3(x: transform.columns.3.x, y: transform.columns.3.y, z: transform.columns.3.z)
//
//            let newEarth = EarthNode()
//            newEarth.position = position
//
//            sceneView.scene.rootNode.addChildNode(newEarth)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
