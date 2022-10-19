//
//  ContentView.swift
//  Chapper
//
//  Created by renaka agusta on 17/10/22.
//

import SwiftUI
import SceneKit

struct ContentView: View {
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

    var body: some View {
        VStack {
            
            Text("hello sayang versi jose")
                .font(.josefinSans(.regular, size: .regular))
                .foregroundColor(Color.bg.secondary)
            
            Text("hello sayang versi rubik")
                .font(.rubik(.regular, size: .title))
            
//            gameView
//            VStack{
//                Spacer()
//                HStack{
//                    AppElevatedButton(label: "<", onClick: {
//                        self.player.moveLeft()
//                    })
//                    AppElevatedButton(label: "||", onClick: {
//                        self.player.stop()
//                    })
//                    AppElevatedButton(label: "^", onClick: {
//                        self.player.start()
//                    })
//                    AppElevatedButton(label: ">", onClick: {
//                        self.player.moveRight()
//                    })
//                }
//                Spacer().frame(height: 20)
//            }.frame(width: UIScreen.width,
//                    height: UIScreen.height)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
