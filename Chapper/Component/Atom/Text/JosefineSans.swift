//
//  JosefineSans.swift
//  Chapper
//
//  Created by Arnold Sidiprasetija on 20/10/22.
//

import SwiftUI

struct AppJosefineSans: View {
    var text: String = ""
    var josepSize: fontType
    var fontWeight: Font.Weight = Font.Weight.medium
    var fontColor: Color = Color.black
    var textAligment: TextAlignment = .center
    

    var body: some View {
        Text(text)
            .font(.josefinSans(.regular, size: josepSize))
            .fontWeight(fontWeight)
            .foregroundColor(fontColor)
            .multilineTextAlignment(textAligment)
    }
}

struct AppJosefineSans_Previews: PreviewProvider {
    static var previews: some View {
        AppJosefineSans(text:"adsad", josepSize: fontType.regular)
    }
}
