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
               backsound: "sadGusde",
               backsoundExtention: "mp3",
               objectList: [
                   ObjectScene(
                       title: "Object 1",
                       description: "Description 1",
                       hint: "Hint 1",
                       tag: "Cube_001",
                       type: ObjectType.Opening,
                       narationDuration: 30,
                       taskDuration: 0,
                       tutorialDuration: 0,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                            Instruction(id: "1", text: "", startedAt: 0),
                            Instruction(id: "2", text: "Halo selamat malam", startedAt: 5),
                            Instruction(id: "3",text: "Malam ini saya akan membawa anda ke taman terindah di [nama app]", startedAt: 10),
                            Instruction(id: "4",text: "Tarik Nafas", startedAt: 15),
                            Instruction(id: "5",text: "Hembuskan", startedAt: 20),
                            Instruction(id: "6",text: "Apakah kamu sudah rileks? Kita akan berkeliling taman ini dengan santai", startedAt: 25)
                       ]
                   ),
                   ObjectScene(
                       title: "Cari pohon biru",
                       description: "Cari pohon biru",
                       hint: "Cari pohon biru",
                       tag: "BLUE",
                       type: ObjectType.Task,
                       narationDuration: 30,
                       taskDuration: 30,
                       tutorialDuration: 20,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                           Instruction(id: "1", text: "Taman ini adalah tempat dimana saya sering bermain di masa kecil", startedAt: 0),
                           Instruction(id: "2",text: "Saya suka bermain di taman ini karena udaranya yang sangat menyejukan", startedAt: 5),
                           Instruction(id: "3",text: "Saat duduk bersandar di bawah pohon sembari membaca buku", startedAt: 10),
                           Instruction(id: "4",text: "Hembuskan", startedAt: 15),
                           Instruction(id: "5",text: "Pohon tersebut berwarna biru dan memiliki banyak dahan", startedAt: 20),
                           Instruction(id: "6",text: "Bisakah kamu menemukan pohon tersebut?", startedAt: 25),
                           Instruction(id: "7",text: "Iya pohon biru itu yang ku maksud", startedAt: 60, gestureType: GestureType.Tap),
                           Instruction(id: "8",text: "Coba tekan pohon itu", startedAt: 65, gestureType: GestureType.Tap),
                       ]
                   ),
                   ObjectScene(
                       title: "Cari pohon kuning",
                       description: "Cari pohon kuning",
                       hint: "Cari pohon kuning",
                       tag: "YELLOW",
                       type: ObjectType.Task,
                       narationDuration: 30,
                       taskDuration: 30,
                       tutorialDuration: 20,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                           Instruction(id: "1", text: "Benar sekali.. Itu pohon yang saya maksud. Sangat besar dan rindang bukan?", startedAt: 0),
                           Instruction(id: "2",text: "Salah satu pohon di taman ini menghasilkan buah yang sangat enak", startedAt: 5),
                           Instruction(id: "3",text: "Buahnya sangat manis dan berair. Di musim panas terasa sangat segar dan nikmat.", startedAt: 10),
                           Instruction(id: "4",text: "Sepanjang ingatan saya pohon tersebut berwarna kuning.", startedAt: 15),
                           Instruction(id: "5",text: "Tapi mari kita lihat apakah pohon tersebut masih ada di taman ini?", startedAt: 20),
                           Instruction(id: "6",text: "Kamu bisa putar taman ini, untuk menemukan pohon kuning", startedAt: 20, gestureType: GestureType.SwipeHorizontal),
                           Instruction(id: "7",text: "", startedAt: 60, gestureType: GestureType.SwipeHorizontal),
                           Instruction(id: "8",text: "", startedAt: 70, gestureType: GestureType.SwipeHorizontal),
                           Instruction(id: "9",text: "", startedAt: 80, gestureType: GestureType.SwipeHorizontal),
                       ]
                   ),
                   ObjectScene(
                       title: "Cari kiki si burung",
                       description: "Cari kiki si burung",
                       hint: "Cari kiki si burung",
                       tag: "BIRD",
                       type: ObjectType.Task,
                       narationDuration: 40,
                       taskDuration: 30,
                       tutorialDuration: 20,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                           Instruction(id: "1", text: "Wah jadi nostalgia. Biasanya saya berbagi buah yang sangat nikmat  ini dengan hewan peliharaan saya", startedAt: 0),
                           Instruction(id: "2",text: "Saya sangat menyukai hewan", startedAt: 5),
                           Instruction(id: "3",text: "Dulu saya memlihara burung kakak tua bernama Kiki di taman ini", startedAt: 10),
                           Instruction(id: "4",text: "Entah mengapa, setiap hari saya hanya menemukan kiki diatas pohon berwarna merah", startedAt: 15),
                           Instruction(id: "5",text: "Apakah dia masih ada disana?", startedAt: 20),  Instruction(id: "5",text: "Iya, kiki  memang sangat kecil", startedAt: 70),
                           Instruction(id: "6",text: "Coba perbesar gambar untuk melihat Kiki", startedAt: 80, gestureType: GestureType.Zoom),
                           Instruction(id: "7",text: "", startedAt: 90, gestureType: GestureType.Zoom),
                           Instruction(id: "8",text: "", startedAt: 100, gestureType: GestureType.Zoom),
                       ]
                   ),
                   ObjectScene(
                       title: "Cari labu putih",
                       description: "Cari labu putih",
                       hint: "Cari labu putih",
                       tag: "PUMPKIN",
                       type: ObjectType.Task,
                       narationDuration: 30,
                       taskDuration: 30,
                       tutorialDuration: 20,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                           Instruction(id: "1", text: "Itu dia Kiki! Ini memang pohon kesukaanya", startedAt: 0),
                           Instruction(id: "2",text: "Pohon ini tidak terlalu tinggi tapi cukup untuk saya bisa bermain dengan Kiki", startedAt: 5),
                           Instruction(id: "3",text: "Kami sering menghabiskan waktu bersama di taman ini", startedAt: 10),
                           Instruction(id: "4",text: "Saya dan Kiki meletakkan hiasan labu berwarna putih di taman ini sebagai tanda persahabatan kami", startedAt: 15),
                           Instruction(id: "5",text: "Coba temukan labu putih itu", startedAt: 20),
                           Instruction(id: "6", text: "Waktu itu aku memang masih pendek, sehingga labu itu hanya. bisa ku taruh di tanah", startedAt: 60, gestureType: GestureType.SwipeHorizontal),
                           Instruction(id: "6",text: "Coba geser taman ini, semoga labu itu masih ada disana", startedAt: 70, gestureType: GestureType.SwipeHorizontal),
                           Instruction(id: "6",text: "", startedAt: 20, gestureType: GestureType.SwipeHorizontal),
                       ]
                   ),
                   ObjectScene(
                       title: "",
                       description: "",
                       hint: "",
                       tag: "BIRD",
                       type: ObjectType.Task,
                       narationDuration: 40,
                       taskDuration: 30,
                       tutorialDuration: 20,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                           Instruction(id: "1", text: "Wah kamu menemukannya!", startedAt: 0),
                           Instruction(id: "2",text: "Karena kamu telah menemukannya, kamu juga menjadi sahabat kami", startedAt: 5),
                           Instruction(id: "3",text: "Kamu dapat berkunjung kembali ke taman ini kapan saja dan bermain bersama kami", startedAt: 10),
                           Instruction(id: "4",text: "Itu saja yang dapat kuceritkan tentang taman ini", startedAt: 15),
                           Instruction(id: "5",text: "Selamat tidur! Semoga malam ini kamu bisa bermimimpi indah", startedAt: 20),
                           Instruction(id: "6",text: "Selamat tidur! Semoga malam ini kamu bisa bermimimpi indah", startedAt: 25),
                           Instruction(id: "7",text: "Mungkin saya dan Kiki akan mampi di mimpumu", startedAt: 30),
                           Instruction(id: "8",text: "Sampai jumpa", startedAt: 35),
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
               backsound: "sadGusde",
               backsoundExtention: "mp3",
               objectList: [
                   ObjectScene(
                       title: "Object 1",
                       description: "Description 1",
                       hint: "Hint 1",
                       tag: "Cube_001",
                       type: ObjectType.Task,
                       narationDuration: 15,
                       taskDuration: 30,
                       tutorialDuration: 20,
                       narationSound: "narasi01",
                       narationSoundExtention: "mp3",
                       instructionList: [
                           Instruction(id: "1", text: "Narasi 1",  startedAt: 0),
                           Instruction(id: "1",text: "Narasi 2", startedAt: 5),
                           Instruction(id: "1",text: "Narasi 3", startedAt: 10)
                       ]
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
