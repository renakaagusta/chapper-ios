//
//  GameViewController.swift
//  test2
//
//  Created by I Gede Bagus Wirawan on 16/10/22.
//

import SwiftUI
import SceneKit
import UIKit
import QuartzCore

import SceneKit.ModelIO
import CoreMotion
import GameController

class GameViewController: UIViewController {
    
    private var scene: SCNScene?
    private var onTap: (_ objectName: String?) -> () = {_ in }
    
    public func loadData(scene: SCNScene, onTap: @escaping (_ objectName: String?) -> ()) {
        self.scene = scene
        self.onTap = onTap

        // retrieve the SCNView
        self.view = SCNView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        onTap(hitResults.first?.node.name ?? "-")
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor(Color.wrong.primary)
            
            SCNTransaction.commit()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}

struct GameView: UIViewControllerRepresentable {
    private var viewController: GameViewController = GameViewController()
    
    func loadData(scene: SCNScene, onTap: @escaping (_ objectName: String?) -> ()) {
        viewController.loadData(scene: scene, onTap: onTap)
    }
    
    func makeUIViewController(context: Context) -> GameViewController {
        return viewController
    }
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
//        update Content
    }
}
