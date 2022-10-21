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
    var percent: CGFloat = 69
    
    var body: some View {
        let multiplier = width / 100
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 17, style: .continuous)
                .frame(width: width, height: height)
            .foregroundColor(Color.foot.primary.opacity(0.5))
            
            RoundedRectangle(cornerRadius: 17, style: .continuous)
                .frame(width: percent * multiplier, height: height)
            .foregroundColor(Color.foot.primary)
        }
        
    }
}

struct AppProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        AppProgressBar()
    }
}
