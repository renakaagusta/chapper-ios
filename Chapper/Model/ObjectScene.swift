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
    var narationDuration: CGFloat
    var instructionList: [Instruction]?
}

struct Instruction: Hashable, Codable, Identifiable {
    var id: String
    var text: String
    var startedAt: CGFloat
}
