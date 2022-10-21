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

enum StoryState {
    case Naration, Task, Tutorial
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
    @State private var narationsProgress: CGFloat = 0
    @State private var state: StoryState = StoryState.Naration
    
    @State private var dialogVisibility = false
    @State private var dialogView: AnyView = AnyView(VStack{})
    
    @State private var focusedObjectIndex = 0
    
    @State private var elapsedTime: CGFloat = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(data: StoryData) {
        self.gameView = GameView()
        
        self.data = data
        
        guard let sceneUrl = Bundle.main.url(forResource: data.sceneName, withExtension: data.sceneExtension) else { fatalError() }
        
        self.scene = try! SCNScene(url: sceneUrl, options: [.checkConsistency: true])
        self.scene?.background.contents = Color.black
        
        self.cameraNode = SCNNode()
        self.cameraNode!.camera = SCNCamera()
        self.scene!.rootNode.addChildNode(cameraNode!)
        self.cameraNode!.position = SCNVector3(x: 0, y: 40, z: 0)
        self.cameraNode?.camera?.fieldOfView = 0
                
        showDialog(position: DialogPosition.Top, child: AnyView(VStack{
            
        }.background(Color.cardColor).frame(width: 100, height: 100)))
    }
    
    func handleTap(hitResults: [SCNHitTestResult]?) {
        if(hitResults == nil || state == StoryState.Naration) {
            return
        }

        if hitResults!.count > 0 {
            let result = hitResults![0]
            
            print("Hit result:")
            print(result.node.name)
            
            let material = result.node.geometry!.firstMaterial!
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
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
    
    func hideDialog() {
        self.dialogVisibility = false
    }
    
    func updateState() {
        if(state == StoryState.Naration) {
            state = StoryState.Task
        } else if(state == StoryState.Tutorial) {
            state = StoryState.Task
        } else if(state == StoryState.Task) {
            if(focusedObjectIndex <
               data.objectList.count - 1) {
                focusedObjectIndex = focusedObjectIndex + 1
            }
        }
    }
    
    func updateTime() {
        elapsedTime = elapsedTime + 1
                        
        var showedInstruction: String?
        for (index, instruction) in data.objectList[focusedObjectIndex].instructionList!.enumerated() {
            if(showedInstruction == nil) {
                if(index != data.objectList[focusedObjectIndex].instructionList!.count - 1) {
                    if(elapsedTime >= instruction.startedAt && elapsedTime < data.objectList[focusedObjectIndex].instructionList![index + 1].startedAt) {
                        showedInstruction = instruction.text
                    }
                } else {
                    hideDialog()
                    showedInstruction = instruction.text
                    if(elapsedTime > data.objectList[focusedObjectIndex].narationDuration) {
                        updateState()
                    }
                }
            }
        }
        
        if(state == StoryState.Naration && showedInstruction != nil) {
            showDialog(position: DialogPosition.Top, child: AnyView(AppRubik(text: showedInstruction!, rubikSize: .headline, fontColor: Color.white)))
        }
        
        narationsProgress = elapsedTime / data.objectList[focusedObjectIndex].narationDuration
    }
    
    var body: some View {
        ZStack {
            VStack{
                gameView
            }
            VStack{
                Spacer().frame(height: 30)
                AppProgressBar(width:300, height: 7, progress: Binding(get:{narationsProgress}, set: {_ in true}))
                            .padding()
                if(dialogVisibility == true) {
                    dialogView
                }
                Spacer().frame(height: 30)
                Spacer()
            }.frame(width: UIScreen.width, height: UIScreen.height).padding()
        }.onAppear(){
            gameView.loadData(scene: self.scene!, onTap: {
                hitResults in
                handleTap(hitResults: hitResults)
            })
        }
        .background(Color.bg.primary)
        .onReceive(timer) { _ in
            updateTime()
                  }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(data: StoryData(id: "0",title: "Example", description: "", thumbnail: "", sceneName: "Project", sceneExtension: "usdc", objectList: []))
    }
}
