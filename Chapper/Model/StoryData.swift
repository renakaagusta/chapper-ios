//
//  StoryData.swift
//  Chapper
//
//  Created by renaka agusta on 19/10/22.
//

import Foundation

struct StoryData: Identifiable {
    var id: String
    var title: String
    var description: String
    var thumbnail: String
    var sceneName: String
    var sceneExtension: String
    var backsound: String
    var backsoundExtention: String
    var objectList: [ObjectScene]
}
