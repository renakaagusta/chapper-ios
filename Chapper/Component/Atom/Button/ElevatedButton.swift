//
//  ElevatedButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppElevatedButton: View {
    
    @State var label: String = "Button"
    @State var height: Double = 0
    @State var width: Double = 0
    @State var textColor: Color = Color.text.primary
    @State var bgColor: Color = Color.sign.primary
    
    var onClick: () -> Void = {}
    
    var body: some View {
        
        Button(action: {
            self.onClick()
        }, label: {

            Text(label)
                .font(.rubik(.regular, size: .body))
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .padding()
                .frame(minWidth: width < 1 ? 0.0 : width, idealWidth: width < 1 ? .infinity : width, maxWidth: width < 1 ? .infinity :width, minHeight: height < 0  ? 0 : height, idealHeight: (height < 1) ? 12 : height,  maxHeight: (height < 1) ? 12 : height)
                .padding()
                .background(bgColor).cornerRadius(50)

        })
    }
}

struct AppElevatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AppElevatedButton(label: "Button")
            .previewLayout(.sizeThatFits)
    }
}
