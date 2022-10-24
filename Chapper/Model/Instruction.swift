//
//  Instruction.swift
//  Chapper
//
//  Created by renaka agusta on 23/10/22.
//

import Foundation

struct Instruction: Hashable, Identifiable {
    var id: String
    var text: String
    var startedAt: CGFloat
    var gestureType: GestureType? = GestureType.None
}
