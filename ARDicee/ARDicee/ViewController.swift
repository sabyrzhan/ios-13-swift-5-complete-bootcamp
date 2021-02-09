//
//  ViewController.swift
//  ARDicee
//
//  Created by Sabyrzhan Tynybayev on 2/4/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var chargers = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = createPlane(with: planeAnchor)
        node.addChildNode(plane)
    }
    
    func createPlane(with planeAnchor: ARPlaneAnchor) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode()
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIColor.init(white: 0, alpha: 0)
        plane.materials = [gridMaterial]
        planeNode.geometry = plane
        
        return planeNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: sceneView)
        guard let raycastQueryResult = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .horizontal) else { return }
        let result = sceneView.session.raycast(raycastQueryResult)
        guard let rayCast = result.first else { return }
        
        addCharger(atLocation: rayCast)
    }
    
    func addCharger(atLocation: ARRaycastResult) {
        let scene = SCNScene(named: "art.scnassets/charger.scn")!
        if let node = scene.rootNode.childNode(withName: "Charger", recursively: true) {
            node.position = SCNVector3(x: atLocation.worldTransform.columns.3.x, y: atLocation.worldTransform.columns.3.y, z: atLocation.worldTransform.columns.3.z)
            self.sceneView.scene.rootNode.addChildNode(node)
            self.chargers.append(node)
            self.roll(charger: node)
        }
    }
    
    @IBAction func removeAllChargers(_ sender: UIBarButtonItem) {
        for charger in chargers {
            charger.removeFromParentNode()
        }
        
        chargers.removeAll()
        
        print("Chargers size after remove: \(chargers.count)")
    }
    
    func rollAll() {
        for charger in chargers {
            roll(charger: charger)
        }
        
        print("Chargers size after add: \(chargers.count)")
    }
    
    func roll(charger: SCNNode) {
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi / 2)
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi / 2)
        charger.runAction(SCNAction.rotateBy(x: CGFloat(randomX * 5), y: 0, z: CGFloat(randomZ * 5), duration: 0.5))
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
    
    @IBAction func rollAgainTapped(_ sender: UIBarButtonItem) {
        rollAll()
    }
}
