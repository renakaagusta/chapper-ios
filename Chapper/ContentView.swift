//
//  ContentView.swift
//  Chapper
//
//  Created by renaka agusta on 17/10/22.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    private var _gameObjects = Array<GameObject>()
    private var _bullets = Array<Bullet>()
    private var _terrain: RBTerrain?
    private var _player: Player?
    private var _touchedRings = 0
    private var _missedRings = 0
    private var _state = GameState.initialized

    var body: some View {
        let gameView = GameView()
        
        var _player = Player()
        
        _player.position = SCNVector3(Game.Level.width/2, CGFloat(Game.Plane.minimumHeight), Game.Level.start)
        
        var _terrain = RBTerrain(width: Int(Game.Level.width), length: Int(Game.Level.length), scale: 96)
        
        let generator = RBPerlinNoiseGenerator(seed: nil)
        _terrain.formula = {(x: Int32, y: Int32) in
            return generator.valueFor(x: x, y: y)
        }
        
        _terrain.create(withColor: UIColor.green)
        _terrain.position = SCNVector3Make(0, 0, 0)
        
        gameView.viewController.load(gameObjects: _gameObjects, player: _player, terrain: _terrain, touchedRings: 0, missedRings: 0, state: GameState.initialized)
        
        return ZStack {
            gameView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
