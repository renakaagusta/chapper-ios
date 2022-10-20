//
//  OutlinedButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppOutlinedButton: View {
    @State var label: String = "Button"
    @State var height: Double = 0.0
    @State var width: Double = 0.0
    @State var color: Color? = Color.text.primary
    @State var borderColor: Color? = Color.sign.primary
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            Text(label).foregroundColor(color).padding()
                .font(.rubik(.regular, size: .body))
                .frame(minWidth: width < 1 ? 0.0 : width, idealWidth: width < 1 ? .infinity : width, maxWidth: width < 1 ? .infinity :width, minHeight: height < 0  ? 0 : height, idealHeight: (height < 1) ? 12 : height,  maxHeight: (height < 1) ? 12 : height).padding().background(Color.clear).overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor!, lineWidth: 2)
                )
        })
    }
}

struct AppOutlinedButton_Previews: PreviewProvider {
    static var previews: some View {
        AppOutlinedButton(label: "Button")
    }
}
