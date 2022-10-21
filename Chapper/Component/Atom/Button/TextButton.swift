//
//  TextButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppTextButton: View {
    @State var textcolor: Color = Color.text.primary
    @State var label: String = "Button"
    @State var height: Double = 0.0
    @State var width: Double = 0.0
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            Text(label)
                .font(.rubik(.regular, size: .body))
                .foregroundColor(textcolor)
                .padding()
        })
    }
}

struct AppTextButton_Previews: PreviewProvider {
    static var previews: some View {
        AppTextButton(label: "Button")
    }
}
