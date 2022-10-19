//
//  Color.swift
//  Chapper
//
//  Created by I Gede Bagus Wirawan on 18/10/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let bg = backgroundColor()
    static let sign = SignifierColor()
    static let spot = SpotlightColor()
    static let text = TextColor()
    static let foot = FootnoteColor()
    static let correct = CorrectColor()
    static let wrong = WrongColor()
    
}

struct backgroundColor {
    let primary = Color("Bg-primary")
    let secondary = Color("Bg-secondary")
    let third = Color("Bg-third")
}

struct SignifierColor {
    let primary = Color("Sign-purple")
}

struct SpotlightColor {
    let primary = Color("Spot-yellow")
}

struct TextColor {
    let primary = Color("Text-gray")
}

struct FootnoteColor {
    let primary = Color("Foot-purple")
}

struct CorrectColor {
    let primary = Color("Correct")
}

struct WrongColor {
    let primary = Color("Wrong")
}
