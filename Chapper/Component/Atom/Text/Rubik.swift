//
//  Rubik.swift
//  Chapper
//
//  Created by Arnold Sidiprasetija on 20/10/22.
//

import SwiftUI


struct AppRubik: View {
    
    var text: String = ""
    var rubikSize: fontType
    var fontWeight: Font.Weight = Font.Weight.medium
    var fontColor: Color = Color.black
    var textAligment: TextAlignment = .center
    
    var body: some View {
        Text(text)
            .font(.rubik(.regular, size: rubikSize))
            .fontWeight(fontWeight)
            .foregroundColor(fontColor)
            .multilineTextAlignment(textAligment)
    }
    
}

struct AppRubik_Previews: PreviewProvider {
    static var previews: some View {
        AppRubik(text: "String", rubikSize: fontType.regular)
    }
}
