//
//  ContentView.swift
//  Chapper
//
//  Created by renaka agusta on 17/10/22.

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        NavigationView {
//            MainMenuView()
            StoryListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
