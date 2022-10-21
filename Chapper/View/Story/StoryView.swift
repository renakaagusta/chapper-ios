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
    private var view: SCNView
    private var cameraNode: SCNNode?
    private var cameraController: SCNCameraController?
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
        
        self.view = SCNView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        guard let sceneUrl = Bundle.main.url(forResource: data.sceneName, withExtension: "scn") else { fatalError() }
        
        self.scene = try! SCNScene(url: sceneUrl, options: [.checkConsistency: true])
        
//        self.cameraNode = SCNNode()
//        self.cameraNode!.camera = SCNCamera()
//        self.scene!.rootNode.addChildNode(cameraNode!)
//        self.cameraNode!.position = SCNVector3(x: 0, y: 50, z: 0)
        
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
    
    func resetCamera() {
        let camera = view.defaultCameraController
        
        print("POSITION")
        print(camera.pointOfView?.position)
        print("EULER ANGLE")
        print(camera.pointOfView?.eulerAngles)
        print("SCALE")
        print(camera.pointOfView?.scale)
        
        camera.pointOfView?.position = SCNVector3(x: 0, y: 178, z: 340)
        camera.pointOfView?.eulerAngles = SCNVector3(x:  -0.22689278, y: 0, z: 0)
        camera.pointOfView?.scale = SCNVector3(x: 1, y: 1, z: 1)
    }
        
        func updateTime() {
            elapsedTime = elapsedTime + 1
            
           resetCamera()
            
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
                showDialog(position: DialogPosition.Top, child: AnyView(AppRubik(text: showedInstruction!, rubikSize: fontType.body, fontWeight: .bold , fontColor: Color.text.primary)))
            }
            
            narationsProgress = elapsedTime / data.objectList[focusedObjectIndex].narationDuration
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                gameView
                if(dialogVisibility == true) {
                    VStack{
                            AppProgressBar(width:300, height: 7, progress: Binding(get:{narationsProgress}, set: {_ in true}))
                    .padding()
                                      if(dialogVisibility == true) {
                                          dialogView
                                      }
                            Spacer()
                    }
                    .frame(width: UIScreen.width, height: UIScreen.height)
                    .padding()
                }
            }
            .onAppear(){
                gameView.loadData(scene: self.scene!, onTap: {
                        hitResults in
                    handleTap(hitResults: hitResults)
                }, view: self.view)
            }.onReceive(timer) { _ in
                updateTime()
                      }
        }
        
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(data: StoryData(id: "0",title: "Example", description: "", thumbnail: "", sceneName: "Project", sceneExtension: "scn", objectList: []))
    }
}
