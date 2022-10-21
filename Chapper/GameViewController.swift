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
    private var onTap: (_ objectName: [SCNHitTestResult]?) -> () = {_ in }
    
    public func loadData(scene: SCNScene, onTap: @escaping (_ objectName: [SCNHitTestResult]?) -> (), view: SCNView) -> SCNCameraController {
        self.scene = scene
        self.onTap = onTap

        self.view = view

        let scnView = self.view as! SCNView
        
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        return scnView.defaultCameraController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
  
        onTap(hitResults)
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
    
    func loadData(scene: SCNScene, onTap: @escaping (_ objectName: [SCNHitTestResult]?) -> (), view: SCNView) -> SCNCameraController {
        return viewController.loadData(scene: scene, onTap: onTap, view: view)
    }
    
    func makeUIViewController(context: Context) -> GameViewController {
        return viewController
    }
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
    }
}
