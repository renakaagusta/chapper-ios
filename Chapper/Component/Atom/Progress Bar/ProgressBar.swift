//
//  ProgressBar.swift
//  Chapper
//
//  Created by Arnold Sidiprasetija on 20/10/22.
//

import SwiftUI

struct AppProgressBar: View {
    var width: CGFloat = 300
    var height: CGFloat = 7
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 17, style: .continuous)
                .frame(width: width, height: height)
            .foregroundColor(Color.foot.primary.opacity(0.3))
            
            RoundedRectangle(cornerRadius: 17, style: .continuous)
                .frame(width: width * (progress > 1 ? 1 : progress), height: height)
                .foregroundColor(Color.foot.primary)
            }
    }
}
//
//struct AppProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        AppProgressBar()
//    }
//}
