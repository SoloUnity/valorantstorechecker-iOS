//
//  WeaponCardDetailView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import SwiftUI
import AVKit

struct SkinCardDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    let player = AVPlayer()
    var displayName:String = ""
    var streamedVideo:String = ""
    
                    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .leading){
                HStack{
                    ExclusiveEditionView()
                        .frame(width:30)

                    Text (String(displayName))
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
                // Skin Video Player
                VideoPlayer(player: player)
                    .cornerRadius(10)
                    .aspectRatio(CGSize(width: 1920, height: 1080), contentMode: .fit)
                    .onAppear{
                          if player.currentItem == nil {
                                let item = AVPlayerItem(url: URL(string: "https://media.valorant-api.com/streamedvideos/VALskinpreview_Alien_Odin_01.mp4")!)
                                player.replaceCurrentItem(with: item)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                player.play() // Autoplay
                            })
                    }
                
            }
            .padding()
        }
        .background(Color(red: 40/255, green: 40/255, blue: 40/255))
    }
}




