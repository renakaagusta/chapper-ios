//
//  StoryView.swift
//  Chapper
//
//  Created by renaka agusta on 17/10/22.

import SwiftUI
import SceneKit

enum DialogPosition {
    case Top, Bottom
}

struct StoryView: View {
    
    private var gameView: GameView
    private var scene: SCNScene?
    private var cameraNode: SCNNode?
    private var lightNode: SCNNode?
    private var ambientLightNode: SCNNode?
    private var objectListNode: Array<SCNNode>?
    private var objectListPosition: Array<SCNVector3>?
    private var data: StoryData
    
    @State private var dialogVisibility = false
    @State private var dialogView: AnyView
    
    init(data: StoryData) {
        self.dialogVisibility = true
        self.dialogView = AnyView(
            AppElevatedButton(label: "Test")
        )
        
        self.gameView = GameView()
        
        self.data = data
        
        guard let sceneUrl = Bundle.main.url(forResource: data.sceneName, withExtension: "scn") else { fatalError() }
        
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
        
        showDialog(position: DialogPosition.Top, child: AnyView(VStack{
            
        }.background(Color.cardColor).frame(width: 100, height: 100)))
    }
    
    func handleTap(objectName: String) {
        print(objectName)
    }
    
    func showDialog(position: DialogPosition, child: AnyView) {
        self.dialogVisibility = true
        if(position == DialogPosition.Top) {
            self.dialogView = AnyView(VStack {
                child
                Spacer()
            })
        } else {
            self.dialogView = AnyView(VStack {
                Spacer()
                child
            })
        }
    }
    
    var body: some View {
        ZStack {
            gameView
            if(dialogVisibility == true) {
                VStack{
                    dialogView
                }.frame(width: UIScreen.width, height: UIScreen.height).padding()
            }
        }.onAppear(){
            gameView.loadData(scene: self.scene!, onTap: {
                objectName in
                handleTap(objectName: objectName!)
            })
           
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(data: StoryData(id: "0",title: "Example", description: "", thumbnail: "", sceneName: "Project", objectList: []))
    }
}
