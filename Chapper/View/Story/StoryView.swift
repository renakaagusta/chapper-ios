//
//  StoryView.swift
//  Chapper
//
//  Created by renaka agusta on 17/10/22.

import SwiftUI
import SceneKit
import AVFoundation

var backsoundPlayer: AVAudioPlayer!
var narationPlayer: AVAudioPlayer!

enum DialogPosition {
    case Top, Bottom
}

struct StoryView: View {
    
    private var gameView: GameView
    private var scene: SCNScene?
    private var view: SCNView
    private var cameraNode: SCNNode?
    private var cameraController: SCNCameraController?
    private var objectListNode: Array<SCNNode>?
    private var objectListPosition: Array<SCNVector3>?
    private var data: StoryData
    
    @State private var narationsProgress: CGFloat = 0
    @State private var state: StoryState = StoryState.Naration
       
    @State private var gestureVisibility = false
    @State private var gesture = ""
    
    @State private var hintVisibility = false
    
    @State private var dialogVisibility = false
    @State private var dialogView: AnyView = AnyView(VStack{})
       
    @State private var focusedObjectIndex = 2
       
    @State private var elapsedTime: CGFloat = 0
       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(data: StoryData) {
        self.gameView = GameView()
        
        self.data = data
        
        self.view = SCNView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        guard let sceneUrl = Bundle.main.url(forResource: data.sceneName, withExtension: data.sceneExtension) else { fatalError() }
        
        self.scene = try! SCNScene(url: sceneUrl, options: [.checkConsistency: true])
    }
    
    func handleTap(hitResults: [SCNHitTestResult]?) {
        if(hitResults == nil || state == StoryState.Naration) {
            return
        }

        if hitResults!.count > 0 {
            let result = hitResults![0]
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

            if(result.node.name == data.objectList[focusedObjectIndex].tag) {
                focusedObjectIndex = focusedObjectIndex + 1
                state = StoryState.Naration
                hintVisibility = false
                gestureVisibility = false
                elapsedTime = 0
                
                playNaration(soundName: data.objectList[focusedObjectIndex].narationSound, soundExtention: data.objectList[focusedObjectIndex].narationSoundExtention)
                
                material.normal.contents = nil
                material.diffuse.contents = nil
                result.node.removeFromParentNode()
            }
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
        let narationTime = data.objectList[focusedObjectIndex].narationDuration
        let taskTime = narationTime + data.objectList[focusedObjectIndex].taskDuration
        let tutorialTime = taskTime + data.objectList[focusedObjectIndex].tutorialDuration
        if(state == StoryState.Naration && elapsedTime > narationTime) {
            if(data.objectList[focusedObjectIndex].type == ObjectType.Opening && elapsedTime > narationTime) {
                focusedObjectIndex = focusedObjectIndex + 1
                hintVisibility = false
            } else {
                state = StoryState.Task
                hintVisibility = true
                hideDialog()
            }
        } else if(state == StoryState.Task && elapsedTime > taskTime) {
            state = StoryState.Tutorial
        } else if(state == StoryState.Tutorial && elapsedTime > tutorialTime) {
            elapsedTime = 0
            focusedObjectIndex = focusedObjectIndex + 1
            state = StoryState.Naration
            hintVisibility = false
            gestureVisibility = false
            
            playNaration(soundName: data.objectList[focusedObjectIndex].narationSound, soundExtention: data.objectList[focusedObjectIndex].narationSoundExtention)
        }
        
    }
    
    func configCamera() {
        let camera = view.defaultCameraController
        
        camera.maximumVerticalAngle = 30
    }
        
    func updateTime() {
        elapsedTime = elapsedTime + 1
    
        configCamera()
        
        updateState()
        
        print("STATE")
        print(state)
        print("TIME")
        print(elapsedTime)
        print("OBJECT INDEX")
        print(focusedObjectIndex)
        print("OBJECT COUNT")
        print(data.objectList.count)
        print("---------")
            
        if(focusedObjectIndex <= data.objectList.count - 1) {
            var showedInstruction: String?
            for (index, instruction) in data.objectList[focusedObjectIndex].instructionList!.enumerated() {
                if(showedInstruction == nil) {
                    if(index != data.objectList[focusedObjectIndex].instructionList!.count - 1) {
                        if(elapsedTime >= instruction.startedAt && elapsedTime < data.objectList[focusedObjectIndex].instructionList![index + 1].startedAt) {
                            showedInstruction = instruction.text
                            
                            if(data.objectList[focusedObjectIndex].instructionList![index].gestureType != GestureType.None && state == StoryState.Tutorial) {
                                gesture = getGestureImage(gesture: data.objectList[focusedObjectIndex].instructionList![index].gestureType! )
                                gestureVisibility = true
                            } else {
                                gestureVisibility = false
                            }
                        }
                    } else {
                        showedInstruction = instruction.text
                        
                        if(data.objectList[focusedObjectIndex].instructionList![index].gestureType != GestureType.None  && state == StoryState.Tutorial) {
                            gesture = getGestureImage(gesture: data.objectList[focusedObjectIndex].instructionList![index].gestureType! )
                            gestureVisibility = true
                        } else {
                            gestureVisibility = false
                        }
                    }
                }
            }
            
            if(state != StoryState.Task && showedInstruction != nil) {
                showDialog(position: DialogPosition.Top, child: AnyView(AppRubik(text: showedInstruction!, rubikSize: fontType.body, fontWeight: .bold , fontColor: Color.text.primary)))
            }
                
            narationsProgress = elapsedTime / data.objectList[focusedObjectIndex].narationDuration

        }
    }
    
    func getGestureImage(gesture: GestureType) -> String {
        switch(gesture) {
            case .Zoom:
                return "hand.zoom"
            case .SwipeHorizontal:
                return "hand.swipe.left.right"
            case .Tap:
                return "hand.tap"
            case .None:
                return "hand.zoom"
            case .SwipeVertical:
                return "hand.swip.up.down"
        }
    }
    
    func playBacksound(soundName: String, soundExtention: String) {
        
        let url = Bundle.main.url(forResource: soundName, withExtension: soundExtention)
        
        guard url != nil else {
            return
        }
        
        do {
            backsoundPlayer = try AVAudioPlayer(contentsOf: url!)
            backsoundPlayer?.setVolume(0.3, fadeDuration: 0.1)
            backsoundPlayer.numberOfLoops = -1
            backsoundPlayer?.play()
        } catch {
            print("error")
        }
    }
    
    func playNaration(soundName: String, soundExtention: String) {
       
        let url = Bundle.main.url(forResource: soundName, withExtension: soundExtention)
        
        guard url != nil else {
            return
        }
        
        do {
            narationPlayer = try AVAudioPlayer(contentsOf: url!)
            narationPlayer?.play()
            narationPlayer.numberOfLoops = 5
        } catch {
            print("error")
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                gameView
                if(gestureVisibility) {
                    GIFView(type: .name(gesture))
                          .frame(maxHeight: 100)
                          .padding()
                }
                if(hintVisibility) {
                    VStack {
                        Spacer().frame(height: UIScreen.height - 600)
                        AppRubik(text: data.objectList[focusedObjectIndex].hint, rubikSize: fontType.body, fontWeight: .bold , fontColor: Color.text.primary)
                    }.frame(width: UIScreen.width, height: UIScreen.height)
                }
                VStack {
                    AppProgressBar(width:300, height: 7, progress:Binding(get:{narationsProgress}, set: {_ in true}))
                        .padding(.top, 50)
                            if(dialogVisibility) {
                                dialogView
                            }
                        Spacer()
                    }
                    .frame(width: UIScreen.width, height: UIScreen.height)
            }.frame(width: UIScreen.width, height: UIScreen.height + 100)
            .onAppear(){
                playBacksound(soundName: data.backsound, soundExtention: data.backsoundExtention)
                playNaration(soundName: data.objectList[focusedObjectIndex].narationSound, soundExtention: data.objectList[focusedObjectIndex].narationSoundExtention)
                
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
        StoryView(data: StoryData(id: "0",title: "Example", description: "", thumbnail: "", sceneName: "Project", sceneExtension: "scn", backsound: "coba", backsoundExtention: "mp3", objectList: []))
    }
}
