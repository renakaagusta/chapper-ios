//
//  EndingView.swift
//  Chapper
//
//  Created by I Gede Bagus Wirawan on 24/10/22.
//

import SwiftUI

struct EndingView: View {
    
    @State var textEnding: String = "Selamat telah menyelesaikan cerita ini"
    @State var buttonTextEnding: String = "Play Again"
    
    var body: some View {
  
        VStack(alignment: .center) {
            
            //text ending
            AppJosefineSans(text: textEnding, josepSize: fontType.largeTitle, fontWeight: Font.Weight.regular, fontColor: Color.text.primary, textAligment: .center)
                .padding()
            
            //Button
            Button(action: {
                //action
            }, label: {
                AppRubik(text: buttonTextEnding, rubikSize: fontType.body, fontWeight: Font.Weight.bold, fontColor: Color.text.primary)
                    .padding()
                    .frame(width: .infinity, height: .infinity)
                    .background(Color.sign.primary)
                    .cornerRadius(500)
            })
            
        }
        .padding()
        .frame(width: UIScreen.width, height: UIScreen.height)
        .background(Color.bg.primary.opacity(0.8))
        
    }
}

struct EndingView_Previews: PreviewProvider {
    static var previews: some View {
        EndingView()
    }
}
