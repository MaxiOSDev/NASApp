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
    @IBOutlet weak var imagesBarButton: UIBarButtonItem!
    
    var newSun = SunNode()
    var newMercury = MercuryNode()
    var newVenus = VenusNode()
    var newEarth = EarthNode()
    var newMars = MarsNode()
    var newJupitar = JupitarNode()
    var newSaturn = SaturnNode()
    var newUranus = UranusNode()
    var newNeptune = NeptuneNode()
    var newPluto = PlutoNode()
    
    let client = NASAClient()
    let dataManager = PlanetGalleryData.sharedInstance
    var chosenPlanet: String?
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
        dataManager.planet = "earth"
        chosenPlanet = "Earth"
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

        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        if sender.selectedSegmentIndex == 0 {
            newSun.position = position
            sceneView.scene.rootNode.addChildNode(newSun)
            dataManager.planet = "sun"
            chosenPlanet = "Sun"
        } else if sender.selectedSegmentIndex == 1 {
            
            newMercury.position = position
            sceneView.scene.rootNode.addChildNode(newMercury)
            dataManager.planet = "mercury"
            chosenPlanet = "Mercury"
        } else if sender.selectedSegmentIndex == 2 {
            
            newVenus.position = position
            sceneView.scene.rootNode.addChildNode(newVenus)
            dataManager.planet = "venus"
            chosenPlanet = "Venus"
        } else if sender.selectedSegmentIndex == 3 {
            
            newEarth.position = position
            sceneView.scene.rootNode.addChildNode(newEarth)
            dataManager.planet = "earth"
            chosenPlanet = "Earth"
        } else if sender.selectedSegmentIndex == 4 {
            
            newMars.position = position
            sceneView.scene.rootNode.addChildNode(newMars)
            dataManager.planet = "mars"
            chosenPlanet = "Mars"
        } else if sender.selectedSegmentIndex == 5 {
            
            newJupitar.position = position
            sceneView.scene.rootNode.addChildNode(newJupitar)
            dataManager.planet = "jupiter"
            chosenPlanet = "Jupiter"
        } else if sender.selectedSegmentIndex == 6 {
            
            newSaturn.position = position
            sceneView.scene.rootNode.addChildNode(newSaturn)
            dataManager.planet = "saturn"
            chosenPlanet = "Saturn"
        } else if sender.selectedSegmentIndex == 7 {
            
            newUranus.position = position
            sceneView.scene.rootNode.addChildNode(newUranus)
            dataManager.planet = "uranus"
            chosenPlanet = "Uranus"
        } else if sender.selectedSegmentIndex == 8 {
            
            newNeptune.position = position
            sceneView.scene.rootNode.addChildNode(newNeptune)
            dataManager.planet = "neptune"
            chosenPlanet = "Neptune"
        } else if sender.selectedSegmentIndex == 9 {
            
            newPluto.position = position
            sceneView.scene.rootNode.addChildNode(newPluto)
            dataManager.planet = "pluto"
            chosenPlanet = "Pluto"
        }
    }
    
    @IBAction func getImages(_ sender: UIBarButtonItem) {
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        
        let touch = touches.first!
        if let hit = sceneView.hitTest(touch.location(in: sceneView), options: nil).first {
            if segmentedControl.selectedSegmentIndex == 0 {
                newSun = hit.node as! SunNode
            } else if segmentedControl.selectedSegmentIndex == 1 {
                newMercury = hit.node as! MercuryNode
            } else if segmentedControl.selectedSegmentIndex == 2 {
                newVenus = hit.node as! VenusNode
            } else if segmentedControl.selectedSegmentIndex == 3 {
                newEarth = hit.node as! EarthNode
            } else if segmentedControl.selectedSegmentIndex == 4 {
                newMars = hit.node as! MarsNode
            } else if segmentedControl.selectedSegmentIndex == 5 {
                newJupitar = hit.node as! JupitarNode
            } else if segmentedControl.selectedSegmentIndex == 6 {
                newSaturn = hit.node as! SaturnNode
            } else if segmentedControl.selectedSegmentIndex == 7 {
                newUranus = hit.node as! UranusNode
            } else if segmentedControl.selectedSegmentIndex == 8 {
                newNeptune = hit.node as! NeptuneNode
            } else if segmentedControl.selectedSegmentIndex == 9 {
                newPluto = hit.node as! PlutoNode
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: sceneView)
        if segmentedControl.selectedSegmentIndex == 0 {
            let zDepth = sceneView.projectPoint(newSun.position).z
            newSun.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 1 {
            let zDepth = sceneView.projectPoint(newMercury.position).z
            newMercury.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 2 {
            let zDepth = sceneView.projectPoint(newVenus.position).z
            newVenus.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 3 {
            let zDepth = sceneView.projectPoint(newEarth.position).z
            newEarth.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 4 {
            let zDepth = sceneView.projectPoint(newMars.position).z
            newMars.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 5 {
            let zDepth = sceneView.projectPoint(newJupitar.position).z
            newJupitar.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 6 {
            let zDepth = sceneView.projectPoint(newSaturn.position).z
            newSaturn.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 7 {
            let zDepth = sceneView.projectPoint(newUranus.position).z
            newUranus.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 8 {
            let zDepth = sceneView.projectPoint(newNeptune.position).z
            newNeptune.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        } else if segmentedControl.selectedSegmentIndex == 9 {
            let zDepth = sceneView.projectPoint(newPluto.position).z
            newPluto.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
        }
    }
    
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

extension ARPlanetController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlanetImages" {
            print("Segue identifier is okay")
            if let planetGalleryVC = segue.destination as? PlanetGalleryController {
                client.parsePlanetGallery(from: .planetGallery) { result in
                    switch result {
                    case .success(let collectionResult):
                        guard var collectionResults = collectionResult else { return }
                        
                        var linkArray = [NASAGalleryLinks]()
                        for link in collectionResults.collection.items {
                            for href in link.links {
                                let hrefString = String(describing: href.href)
                                if hrefString.range(of: ".jpg") != nil {
                                    linkArray.append(link)
                                    //      print("Yes \(href.href)\n")
                                } else {
                                    //      print("No \(href.href)\n")
                                }
                            }
                        }
                        
                        print("Before chosen planet \(self.chosenPlanet)")
                        planetGalleryVC.chosenPlanet = self.chosenPlanet!
                        print(collectionResults.collection.items.count)
                        collectionResults.collection.items.removeAll()
                        collectionResults.collection.items = linkArray
                        planetGalleryVC.galleryLinks = collectionResults
                        print(collectionResults.collection.items.count)
                        planetGalleryVC.collectionView?.reloadData()
                    case .failure(let error):
                        print("Error in AR Planet Controller Client: \(error)")
                    }
                }
            }
        }
    }
}



