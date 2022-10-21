//
//  StoryListView.swift
//  Chapper
//
//  Created by renaka agusta on 19/10/22.
//

import SwiftUI

struct StoryListView: View {
    
    var storyList = [
           StoryData(
               id: "1",
               title: "Story 1",
               description: "Description 1",
               thumbnail: "",
               sceneName: "3DAssetS1",
               sceneExtension: "scn",
               objectList: [
                   ObjectScene(
                       title: "Object 1",
                       description: "Description 1",
                       hint: "Hint 1",
                       tag: "Cube_001",
                       narationDuration: 15,
                       instructionList: [
                           Instruction(id: "1", text: "Narasi 1", startedAt: 0),
                           Instruction(id: "1",text: "Narasi 2", startedAt: 5),
                           Instruction(id: "1",text: "Narasi 3", startedAt: 10)
                       ]
                   )
               ]
           ),
           StoryData(
               id: "2",
               title: "Story 2",
               description: "Description 1",
               thumbnail: "",
               sceneName: "3DAssetS1",
               sceneExtension: "scn",
               objectList: [
                   ObjectScene(
                       title: "Object 1",
                       description: "Description 1",
                       hint: "Hint 1",
                       tag: "Cube_001",
                       narationDuration: 15
                   )
               ]
           )
       ]
    
    var body: some View {
        VStack {
            List {
                ForEach(storyList) { story in
                    NavigationLink(destination: StoryView(data: story).navigationBarBackButtonHidden(true), label: {
                        Text(story.title)
                    })
                }
            }
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
