//
//  NumberField.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI
import UIKit

struct AppNumberField: View {
    @State var placeholder = "Search..."
    @Binding var field: Double
    @State var image = ""
    @State var numberInput = false
    @FocusState var isFocus: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                if(image != "") {
                    Image(systemName: "magnifyingglass")
                }
                TextField(placeholder, value: $field, formatter: NumberFormatter()).focused($isFocus).frame(minWidth:0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 8, maxHeight: 8)
//                    .keyboardType(.decimalPad) .toolbar{
//                        ToolbarItemGroup(placement: .keyboard) {
//                            Button("Done") {
//                                isFocus = false
//                            }
//                    }
//            }
                    .padding()
            Divider()
                .frame(height: 0.5)
        }
        }
    }
}
