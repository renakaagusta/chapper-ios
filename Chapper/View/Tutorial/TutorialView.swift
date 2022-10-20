//
//  TutorialView.swift
//  Chapper
//
//  Created by I Gede Bagus Wirawan on 20/10/22.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        
        ZStack {
            
            GameView()

            VStack {
                
                AppProgressBar(width:300, height: 7)
                    .padding()
                
                AppRubik(text: "Hallo selamat datang", rubikSize: fontType.body, fontWeight: .bold , fontColor: Color.text.primary)
                
                Spacer()
                
                
                
            }
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.bg.primary.opacity(0.75), Color.bg.third.opacity(0.75)]), startPoint: .topTrailing, endPoint: .bottomLeading)
        )
        .background(Color.bg.primary)
        
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
