//
//  MainMenuView.swift
//  Chapper
//
//  Created by renaka agusta on 19/10/22.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack{
            NavigationLink(destination: StoryListView(), label: {
                Text("Story List")
            })
            NavigationLink(destination: HelpView(), label: {
                Text("Help")
            })
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
