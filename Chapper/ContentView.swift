//
//  ContentView.swift
//  Chapper
//
//  Created by renaka agusta on 17/10/22.
//

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
