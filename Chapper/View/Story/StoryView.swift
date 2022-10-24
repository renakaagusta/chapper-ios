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
    @State private var endingVisibility: Bool = false
    
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
                
                if(focusedObjectIndex == data.objectList.count - 1) {
                    endingVisibility = true
                    updateState()
                }
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
        if(focusedObjectIndex < data.objectList.count && endingVisibility == false) {
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
                
                if(focusedObjectIndex < data.objectList.count) {
                    playNaration(soundName: data.objectList[focusedObjectIndex].narationSound, soundExtention: data.objectList[focusedObjectIndex].narationSoundExtention)
                } else {
                    endingVisibility = true
                }
            }
        } else {
            endingVisibility = true
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

        } else {
            endingVisibility = true
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
                if(endingVisibility) {
                    EndingView(textEnding: "Selamat telah menyelesaikan cerita ini", buttonTextEnding: "Main lagi")
                }
                if(gestureVisibility) {
                    GIFView(type: .name(gesture))
                        .frame(maxHeight: 100)
                        .padding()
                }
                if(hintVisibility) {
                    VStack {
                        Spacer().frame(height: UIScreen.height - 200)
                        AppRubik(text: data.objectList[focusedObjectIndex].hint, rubikSize: fontType.body, fontWeight: .bold , fontColor: Color.text.primary)
                            
                    }
                    .frame(width:  UIScreen.width, height: UIScreen.height)
                }
                if(endingVisibility == false ) {
                    VStack {
                        AppProgressBar(width:300, height: 7, progress:Binding(get:{narationsProgress}, set: {_ in true}))
                            .padding(.top, 60)
                                if(dialogVisibility && !endingVisibility) {
                                    dialogView
                                        .padding(.horizontal, 50)
                                        .padding(.top)
                                }
                            Spacer()
                        }
                        .frame(width: UIScreen.width, height: UIScreen.height)
                }
                
                VStack(alignment: .trailing) {
                    Spacer().frame(height: UIScreen.height - 150)
                    HStack {
                        Spacer().frame(width: UIScreen.width - 100)
                        if(hintVisibility == false) {
                            AppCircleButton(
                                size: 20,
                                icon: Image(systemName: "lightbulb.fill"),
                                color: Color.bg.primary,
                                backgroundColor: Color.foot.primary,
                                source: AppCircleButtonContentSource.Icon
                                //onClick:
                            )
                            .padding()
                        }
                        
                        if(hintVisibility ==  true) {
                            AppCircleButton(
                                size: 20,
                                icon: Image(systemName: "lightbulb.fill"),
                                color: Color.bg.primary,
                                backgroundColor: Color.spot.primary,
                                source: AppCircleButtonContentSource.Icon
                                //onClick:
                            )
                            .padding()
                            .shadow(color: Color.spot.primary, radius: 15, x: 0, y: 0)
                        }

                    }

                }
                
            }
            .frame(width: UIScreen.width, height: UIScreen.height + 100)
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
        StoryView(data:  StoryData(
            id: "1",
            title: "Story 1",
            description: "Description 1",
            thumbnail: "",
            sceneName: "3DAssetS1",
            sceneExtension: "scn",
            backsound: "sadGusde",
            backsoundExtention: "mp3",
            objectList: [
                ObjectScene(
                    title: "Object 1",
                    description: "Description 1",
                    hint: "Hint 1",
                    tag: "Cube_001",
                    type: ObjectType.Opening,
                    narationDuration: 30,
                    taskDuration: 0,
                    tutorialDuration: 0,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                         Instruction(id: "1", text: "", startedAt: 0),
                         Instruction(id: "2", text: "Halo selamat malam", startedAt: 5),
                         Instruction(id: "3",text: "Malam ini saya akan membawa anda ke taman terindah di [nama app]", startedAt: 10),
                         Instruction(id: "4",text: "Tarik Nafas", startedAt: 15),
                         Instruction(id: "5",text: "Hembuskan", startedAt: 20),
                         Instruction(id: "6",text: "Apakah kamu sudah rileks? Kita akan berkeliling taman ini dengan santai", startedAt: 25)
                    ]
                ),
                ObjectScene(
                    title: "Cari pohon biru",
                    description: "Cari pohon biru",
                    hint: "Cari pohon biru",
                    tag: "BLUE",
                    type: ObjectType.Task,
                    narationDuration: 30,
                    taskDuration: 30,
                    tutorialDuration: 20,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                        Instruction(id: "1", text: "Taman ini adalah tempat dimana saya sering bermain di masa kecil", startedAt: 0),
                        Instruction(id: "2",text: "Saya suka bermain di taman ini karena udaranya yang sangat menyejukan", startedAt: 5),
                        Instruction(id: "3",text: "Saat duduk bersandar di bawah pohon sembari membaca buku", startedAt: 10),
                        Instruction(id: "4",text: "Hembuskan", startedAt: 15),
                        Instruction(id: "5",text: "Pohon tersebut berwarna biru dan memiliki banyak dahan", startedAt: 20),
                        Instruction(id: "6",text: "Bisakah kamu menemukan pohon tersebut?", startedAt: 25),
                        Instruction(id: "7",text: "Iya pohon biru itu yang ku maksud", startedAt: 60, gestureType: GestureType.Tap),
                        Instruction(id: "8",text: "Coba tekan pohon itu", startedAt: 65, gestureType: GestureType.Tap),
                    ]
                ),
                ObjectScene(
                    title: "Cari pohon kuning",
                    description: "Cari pohon kuning",
                    hint: "Cari pohon kuning",
                    tag: "YELLOW",
                    type: ObjectType.Task,
                    narationDuration: 30,
                    taskDuration: 30,
                    tutorialDuration: 20,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                        Instruction(id: "1", text: "Benar sekali.. Itu pohon yang saya maksud. Sangat besar dan rindang bukan?", startedAt: 0),
                        Instruction(id: "2",text: "Salah satu pohon di taman ini menghasilkan buah yang sangat enak", startedAt: 5),
                        Instruction(id: "3",text: "Buahnya sangat manis dan berair. Di musim panas terasa sangat segar dan nikmat.", startedAt: 10),
                        Instruction(id: "4",text: "Sepanjang ingatan saya pohon tersebut berwarna kuning.", startedAt: 15),
                        Instruction(id: "5",text: "Tapi mari kita lihat apakah pohon tersebut masih ada di taman ini?", startedAt: 20),
                        Instruction(id: "6",text: "Kamu bisa putar taman ini, untuk menemukan pohon kuning", startedAt: 20, gestureType: GestureType.SwipeHorizontal),
                        Instruction(id: "7",text: "", startedAt: 60, gestureType: GestureType.SwipeHorizontal),
                        Instruction(id: "8",text: "", startedAt: 70, gestureType: GestureType.SwipeHorizontal),
                        Instruction(id: "9",text: "", startedAt: 80, gestureType: GestureType.SwipeHorizontal),
                    ]
                ),
                ObjectScene(
                    title: "Cari kiki si burung",
                    description: "Cari kiki si burung",
                    hint: "Cari kiki si burung",
                    tag: "BIRD",
                    type: ObjectType.Task,
                    narationDuration: 40,
                    taskDuration: 30,
                    tutorialDuration: 20,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                        Instruction(id: "1", text: "Wah jadi nostalgia. Biasanya saya berbagi buah yang sangat nikmat  ini dengan hewan peliharaan saya", startedAt: 0),
                        Instruction(id: "2",text: "Saya sangat menyukai hewan", startedAt: 5),
                        Instruction(id: "3",text: "Dulu saya memlihara burung kakak tua bernama Kiki di taman ini", startedAt: 10),
                        Instruction(id: "4",text: "Entah mengapa, setiap hari saya hanya menemukan kiki diatas pohon berwarna merah", startedAt: 15),
                        Instruction(id: "5",text: "Apakah dia masih ada disana?", startedAt: 20),  Instruction(id: "5",text: "Iya, kiki  memang sangat kecil", startedAt: 70),
                        Instruction(id: "6",text: "Coba perbesar gambar untuk melihat Kiki", startedAt: 80, gestureType: GestureType.Zoom),
                        Instruction(id: "7",text: "", startedAt: 90, gestureType: GestureType.Zoom),
                        Instruction(id: "8",text: "", startedAt: 100, gestureType: GestureType.Zoom),
                    ]
                ),
                ObjectScene(
                    title: "Cari labu putih",
                    description: "Cari labu putih",
                    hint: "Cari labu putih",
                    tag: "PUMPKIN",
                    type: ObjectType.Task,
                    narationDuration: 30,
                    taskDuration: 30,
                    tutorialDuration: 20,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                        Instruction(id: "1", text: "Itu dia Kiki! Ini memang pohon kesukaanya", startedAt: 0),
                        Instruction(id: "2",text: "Pohon ini tidak terlalu tinggi tapi cukup untuk saya bisa bermain dengan Kiki", startedAt: 5),
                        Instruction(id: "3",text: "Kami sering menghabiskan waktu bersama di taman ini", startedAt: 10),
                        Instruction(id: "4",text: "Saya dan Kiki meletakkan hiasan labu berwarna putih di taman ini sebagai tanda persahabatan kami", startedAt: 15),
                        Instruction(id: "5",text: "Coba temukan labu putih itu", startedAt: 20),
                        Instruction(id: "6", text: "Waktu itu aku memang masih pendek, sehingga labu itu hanya. bisa ku taruh di tanah", startedAt: 60, gestureType: GestureType.SwipeHorizontal),
                        Instruction(id: "6",text: "Coba geser taman ini, semoga labu itu masih ada disana", startedAt: 70, gestureType: GestureType.SwipeHorizontal),
                        Instruction(id: "6",text: "", startedAt: 20, gestureType: GestureType.SwipeHorizontal),
                    ]
                ),
                ObjectScene(
                    title: "",
                    description: "",
                    hint: "",
                    tag: "BIRD",
                    type: ObjectType.Task,
                    narationDuration: 40,
                    taskDuration: 30,
                    tutorialDuration: 20,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                        Instruction(id: "1", text: "Wah kamu menemukannya!", startedAt: 0),
                        Instruction(id: "2",text: "Karena kamu telah menemukannya, kamu juga menjadi sahabat kami", startedAt: 5),
                        Instruction(id: "3",text: "Kamu dapat berkunjung kembali ke taman ini kapan saja dan bermain bersama kami", startedAt: 10),
                        Instruction(id: "4",text: "Itu saja yang dapat kuceritkan tentang taman ini", startedAt: 15),
                        Instruction(id: "5",text: "Selamat tidur! Semoga malam ini kamu bisa bermimimpi indah", startedAt: 20),
                        Instruction(id: "6",text: "Selamat tidur! Semoga malam ini kamu bisa bermimimpi indah", startedAt: 25),
                        Instruction(id: "7",text: "Mungkin saya dan Kiki akan mampi di mimpumu", startedAt: 30),
                        Instruction(id: "8",text: "Sampai jumpa", startedAt: 35),
                    ]
                ),
                ObjectScene(
                    title: "Selamat telah menyelesaikan cerita ini",
                    description: "Selamat telah menyelesaikan cerita ini",
                    hint: "Selamat telah menyelesaikan cerita ini",
                    tag: "BIRD",
                    type: ObjectType.Ending,
                    narationDuration: 40,
                    taskDuration: 30,
                    tutorialDuration: 20,
                    narationSound: "narasi01",
                    narationSoundExtention: "mp3",
                    instructionList: [
                    ]
                )
            ]
        ))
    }
}
