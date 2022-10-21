//
//  Font.swift
//  Chapper
//
//  Created by I Gede Bagus Wirawan on 19/10/22.
//

/*
 
 font names = [["JosefinSansRoman-Regular", "JosefinSans-Thin", "JosefinSansRoman-ExtraLight", "JosefinSansRoman-Light", "JosefinSansRoman-Medium", "JosefinSansRoman-SemiBold", "JosefinSansRoman-Bold"]]
 
 family name = [Rubik]
 font names = [["RubikRoman-Regular", "Rubik-Light", "RubikRoman-Medium", "RubikRoman-SemiBold", "RubikRoman-Bold", "RubikRoman-ExtraBold", "RubikRoman-Black"]]
 
 */

import Foundation
import SwiftUI

//Dynamic Type Font
enum fontType: CGFloat {
    case title1 = 28.0
    case title2 = 22.0
    case title3 = 20.0
    case headline = 17.5
    case subheadline = 15.0
    case regular = 18.0
    case body = 17.0
    case callout = 16.0
    case footnote = 13.0
    case caption1 = 12.0
    case caption2 = 11.0
    case largeTitle = 34.0
}

//josefinSans Font
enum josefinSansFont: String {
    case regular = "JosefinSansRoman-Regular"
    case thin = "JosefinSans-Thin"
    case extraLight = "JosefinSansRoman-ExtraLight"
    case light = "JosefinSansRoman-Light"
    case medium = "JosefinSansRoman-Medium"
    case semoBold = "JosefinSansRoman-SemiBold"
    case Bold = "JosefinSansRoman-Bold"
}

//Rubik Font
enum rubikFont: String {
    case regular = "RubikRoman-Regular"
    case light = "Rubik-Light"
    case medium = "RubikRoman-Medium"
    case semoBold = "RubikRoman-SemiBold"
    case bold = "RubikRoman-Bold"
    case extraBold = "RubikRoman-ExtraBold"
    case black = "RubikRoman-Black"
}


extension Font {
    
    static func josefinSans(_ font: josefinSansFont, size: fontType) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.rawValue, size: size.rawValue)
    }
    
    static func rubik(_ font: rubikFont, size: fontType) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.rawValue, size: size.rawValue)
    }
    
}

/*
 ====for check font family names====
 
 init(){
     printFonts()
 }
 
 func printFonts() {
     let fontFamilyName = UIFont.familyNames
     
     for familyName in fontFamilyName {
         print("-----")
         print("family name = [\(familyName)]")
         let names = UIFont.fontNames(forFamilyName: familyName)
         print("font names = [\(names)]")
     }
 }
 */



