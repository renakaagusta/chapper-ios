////
////  ContentView.swift
////  Chapper
////
////  Created by renaka agusta on 17/10/22.
////
//
//import SwiftUI
//import SceneKit
//
//struct ContentView: View {
//    private var gameView: GameView
//
//    private var gameObjects: Array<GameObject>
//    private var bullets: Array<Bullet>
//    private var terrain: RBTerrain
//    private var player: Player
//    private var touchedRings: Int
//    private var missedRings: Int
//    private var state = GameState.initialized
//
//    init() {
//        self.gameView = GameView()
//
//        self.gameObjects = Array<GameObject>()
//
//        self.bullets = Array<Bullet>()
//
//        self.player = Player()
//        self.player.position = SCNVector3(Game.Level.width/2, CGFloat(Game.Plane.minimumHeight), Game.Level.start)
//
//        self.terrain = RBTerrain(width: Int(Game.Level.width), length: Int(Game.Level.length), scale: 96)
//        let generator = RBPerlinNoiseGenerator(seed: nil)
//        self.terrain.formula = {(x: Int32, y: Int32) in
//            return generator.valueFor(x: x, y: y)
//        }
//        self.terrain.create(withColor: UIColor.green)
//        self.terrain.position = SCNVector3Make(0, 0, 0)
//
//        self.touchedRings = 0
//        self.missedRings = 0
//
//        self.gameView.viewController.load(gameObjects: self.gameObjects, player: self.player, terrain: self.terrain, touchedRings: 0, missedRings: 0, state: GameState.initialized)
//    }
//
//    var body: some View {
//        VStack {
//
//            Text("hello sayang versi jose")
//                .font(.josefinSans(.regular, size: .regular))
//                .foregroundColor(Color.bg.third)
//
//            Text("hello sayang versi rubik")
//                .font(.rubik(.regular, size: .title1))
//                .foregroundColor(Color.bg.primary)
//
////            gameView
////            VStack{
////                Spacer()
////                HStack{
////                    AppElevatedButton(label: "<", onClick: {
////                        self.player.moveLeft()
////                    })
////                    AppElevatedButton(label: "||", onClick: {
////                        self.player.stop()
////                    })
////                    AppElevatedButton(label: "^", onClick: {
////                        self.player.start()
////                    })
////                    AppElevatedButton(label: ">", onClick: {
////                        self.player.moveRight()
////                    })
////                }
////                Spacer().frame(height: 20)
////            }.frame(width: UIScreen.width,
////                    height: UIScreen.height)
//
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI
import SceneKit

struct ContentView: View {
    
    private var gameView: GameView
    private var scene: SCNScene?
    private var cameraNode: SCNNode?
    private var lightNode: SCNNode?
    private var ambientLightNode: SCNNode?
    private var objectListNode: Array<SCNNode>?
    private var objectListPosition: Array<SCNVector3>?
    
    init() {
        self.gameView = GameView()
        
        guard let sceneUrl = Bundle.main.url(forResource: "Project", withExtension: "usdc") else { fatalError() }
        self.scene = try! SCNScene(url: sceneUrl, options: [.checkConsistency: true])
        
        self.cameraNode = SCNNode()
        self.cameraNode!.camera = SCNCamera()
        self.scene!.rootNode.addChildNode(cameraNode!)
        self.cameraNode!.position = SCNVector3(x: 0, y: 50, z: 15)
        
        self.lightNode = SCNNode()
        self.lightNode!.light = SCNLight()
        self.lightNode!.light!.type = .omni
        self.lightNode!.position = SCNVector3(x: 0, y: 10, z: 10)
        self.scene!.rootNode.addChildNode(lightNode!)
        
        self.ambientLightNode = SCNNode()
        self.ambientLightNode!.light = SCNLight()
        self.ambientLightNode!.light!.type = .ambient
        self.ambientLightNode!.light!.color = UIColor.darkGray
        self.scene!.rootNode.addChildNode(ambientLightNode!)
        
        guard let shipUrl = Bundle.main.url(forResource: "Ship", withExtension: "scn") else { fatalError() }
        let shipScene = try! SCNScene(url: shipUrl, options: [.checkConsistency: true])
        
        self.scene!.rootNode.addChildNode(shipScene.rootNode)
        
        
    }
    
    func handleTap(objectName: String) {
        print(objectName)
    }
    
    var body: some View {
        ZStack {
            gameView
        }.onAppear(){
            gameView.loadData(scene: self.scene!, onTap: {
                objectName in
                handleTap(objectName: objectName!)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
