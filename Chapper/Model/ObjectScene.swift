//
//  ObjectScene.swift
//  Chapper
//
//  Created by renaka agusta on 19/10/22.
//

import Foundation

struct ObjectScene {
    var title: String
    var description: String
    var hint: String
    var tag: String
    var type: ObjectType
    var narationDuration: CGFloat
    var taskDuration: CGFloat
    var tutorialDuration: CGFloat
    var narationSound : String
    var narationSoundExtention: String
    var instructionList: [Instruction]?
}
