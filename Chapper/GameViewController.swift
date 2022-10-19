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

//class GameViewController: UIViewController, SCNSceneRendererDelegate {
//    private var _sceneView: SCNView!
//    private var _level: GameLevel!
////    private var _hud: HUD!
//
//    // New in Part 5: Use CoreMotion to fly the plane
//    private var _motionManager = CMMotionManager()
//    private var _startAttitude: CMAttitude?             // Start attitude
//    private var _currentAttitude: CMAttitude?           // Current attitude
//
//    private var _gameObjects = Array<GameObject>()
//    private var _bullets = Array<Bullet>()
//    private var _terrain: RBTerrain?
//    private var _player: Player?
//    private var _touchedRings = 0
//    private var _missedRings = 0
//    private var _state = GameState.initialized
//
//    // -------------------------------------------------------------------------
//    // MARK: - Properties
//
//    var sceneView: SCNView {
//        return _sceneView
//    }
//
//    // -------------------------------------------------------------------------
//
////    var hud: HUD {
////        return _hud
////    }
//
//    // -------------------------------------------------------------------------
//    // MARK: - Render delegate (New in Part 4)
//
//    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
//        guard _level != nil else { return }
//
//        _level.update(atTime: time)
//        renderer.loops = true
//    }
//
//    // -------------------------------------------------------------------------
//    // MARK: - Gesture recognoizers
//
//    @objc private func handleTap(_ gestureRecognize: UITapGestureRecognizer) {
//        // New in Part 4: A tap is used to restart the level (see tutorial)
//        if _level.state == .loose || _level.state == .win {
//            _level.stop()
//            _level = nil
//
//            DispatchQueue.main.async {
//                // Create things in main thread
//
//                let level = GameLevel()
//                level.create()
//
////                level.hud = self.hud
////                self.hud.reset()
//
//                self.sceneView.scene = level
//                self._level = level
//
////                self.hud.message("READY?", information: "- Touch screen to start -")
//            }
//        }
//            // New in Part 5: A tap is used to start the level (see tutorial)
//        else if _level.state == .ready {
//            _startAttitude = _currentAttitude
//            _level.start()
//        }
//        // New in Part 6: A tap is used to shot fire (see tutorial)
//        else if _level.state == .play {
//            _level.fire()
//        }
//    }
//
//    // -------------------------------------------------------------------------
//
//    @objc private func handleSwipe(_ gestureRecognize: UISwipeGestureRecognizer) {
//        if _level.state != .play {
//            return
//        }
//
//        if (gestureRecognize.direction == .left) {
//            _level!.swipeLeft()
//        }
//        else if (gestureRecognize.direction == .right) {
//            _level!.swipeRight()
//        }
//        else if (gestureRecognize.direction == .down) {
//            _level!.swipeDown()
//        }
//        else if (gestureRecognize.direction == .up) {
//            _level!.swipeUp()
//        }
//    }
//
//    // -------------------------------------------------------------------------
//    // MARK: - Motion handling
//
//    private func motionDidChange(data: CMDeviceMotion) {
//        _currentAttitude = data.attitude
//
//        guard _level != nil, _level?.state == .play else { return }
//
//        // Up/Down
//        let diff1 = _startAttitude!.roll - _currentAttitude!.roll
//
//        if (diff1 >= Game.Motion.threshold) {
//            _level!.motionMoveUp()
//        }
//        else if (diff1 <= -Game.Motion.threshold) {
//            _level!.motionMoveDown()
//        }
//        else {
//            _level!.motionStopMovingUpDown()
//        }
//
//        let diff2 = _startAttitude!.pitch - _currentAttitude!.pitch
//
//        if (diff2 >= Game.Motion.threshold) {
//            _level!.motionMoveLeft()
//        }
//        else if (diff2 <= -Game.Motion.threshold) {
//            _level!.motionMoveRight()
//        }
//        else {
//            _level!.motionStopMovingLeftRight()
//        }
//    }
//
//    // -------------------------------------------------------------------------
//
//    private func setupMotionHandler() {
//        if (GCController.controllers().count == 0 && _motionManager.isAccelerometerAvailable) {
//            _motionManager.accelerometerUpdateInterval = 1/60.0
//
//            _motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {(data, error) in
//                self.motionDidChange(data: data!)
//            })
//        }
//    }
//
//    // -------------------------------------------------------------------------
//    // MARK: - ViewController life cycle
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        // Part 3: HUD is created and assigned to view and game level
////        _hud = HUD(size: self.view.bounds.size)
////        _level.hud = _hud
////        _sceneView.overlaySKScene = _hud.scene
//
////        self.hud.message("READY?", information: "- Touch screen to start -")
//    }
//
//    // -------------------------------------------------------------------------
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//    public func load(gameObjects: Array<GameObject>, player: Player?, terrain: RBTerrain, touchedRings: Int, missedRings: Int, state: GameState) {
//        _gameObjects = gameObjects
//        _player = player
//        _terrain = terrain
//        _touchedRings = touchedRings
//        _missedRings = missedRings
//        _state = state
//
//        _level = GameLevel(gameObjects: _gameObjects, player: _player, terrain: _terrain!, touchedRings: _touchedRings, missedRings: _missedRings, state: _state)
//
//        _level.create()
//
//        _sceneView = SCNView()
//        _sceneView.scene = _level
//        _sceneView.allowsCameraControl = false
//        _sceneView.showsStatistics = false
//        _sceneView.backgroundColor = UIColor.black
//        _sceneView.delegate = self
//
//        self.view = _sceneView
//
//        setupMotionHandler()
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        _sceneView!.addGestureRecognizer(tapGesture)
//
//        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
//        swipeLeftGesture.direction = .left
//        _sceneView!.addGestureRecognizer(swipeLeftGesture)
//
//        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
//        swipeRightGesture.direction = .right
//        _sceneView!.addGestureRecognizer(swipeRightGesture)
//
//        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
//        swipeDownGesture.direction = .down
//        _sceneView!.addGestureRecognizer(swipeDownGesture)
//
//        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
//        swipeUpGesture.direction = .up
//        _sceneView!.addGestureRecognizer(swipeUpGesture)
//    }
//
//    // -------------------------------------------------------------------------
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    // -------------------------------------------------------------------------
//
//}
//
//struct GameView: UIViewControllerRepresentable {
//    let viewController = GameViewController()
//
//    func makeUIViewController(context: Context) -> GameViewController {
//        return viewController
//    }
//    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
//        //update Content
//    }
//}


class GameViewController: UIViewController {
    
    private var scene: SCNScene?
    private var onTap: (_ objectName: String?) -> () = {_ in }
    
    public func loadData(scene: SCNScene, onTap: @escaping (_ objectName: String?) -> ()) {
        self.scene = scene
        self.onTap = onTap
        
//        self.cameraNode = cameraNode
//        self.lightNode = lightNode
//        self.ambientLightNode = ambientLightNode
//        self.objectListNode = objectListNode
//        self.objectListPosition = objectListPosition
        
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
            
            material.emission.contents = UIColor.red
            
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
        //update Content
    }
}
