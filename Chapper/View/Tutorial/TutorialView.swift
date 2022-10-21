//
//  TutorialView.swift
//  Chapper
//
//  Created by I Gede Bagus Wirawan on 20/10/22.
//

import SwiftUI

struct TutorialView: View {
    
    @State var percent: CGFloat = 0
    @State var text: String = "Hallo selamat datang"
    
    var body: some View {
    
        VStack {
            
//            AppProgressBar(width:300, height: 7, percent: percent)
//                .padding()
            
            AppRubik(text: text, rubikSize: fontType.body, fontWeight: .bold , fontColor: Color.text.primary)
            
            Spacer()
            
            //AppCircleButton(size: 25, icon: AppImage(height: 15, width: 15, url: "lightbulb.fill", source: AppImageSource.SystemName), color: Color.bg.primary, backgroundColor: Color.foot.primary, source: AppCircleButtonContentSource.Icon) {
                //
            //}
            //AppCircleButton(icon: AppImage(height: 20, width: 20, url: "lightbulb.fill", source: AppImageSource.SystemName, color: Color.bg.primary, component: {}) backgroundColor: Color.foot.primary, source: AppCircleButtonContentSource.Icon) {
                //
            //}
            
        }.padding()
        
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
