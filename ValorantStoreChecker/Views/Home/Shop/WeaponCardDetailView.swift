//
//  WeaponCardDetailView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import SwiftUI
import AVKit

struct WeaponCardDetailView: View {
    
    let player = AVPlayer()
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .leading){
                Text ("Glitchpop Dagger")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                VideoPlayer(player: player)
                    .cornerRadius(10)
                    .aspectRatio(CGSize(width: 1920, height: 1080), contentMode: .fit)
                    .onAppear{
                          if player.currentItem == nil {
                                let item = AVPlayerItem(url: URL(string: "https://media.valorant-api.com/streamedvideos/VALskinpreview_GlitchpopMelee02_r02.mp4")!)
                                player.replaceCurrentItem(with: item)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                player.play()
                            })
                        }

                
                
            }
            .padding()
        }
        
        .background(Color(red: 40/255, green: 40/255, blue: 40/255))
    }
}

struct WeaponCardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponCardDetailView()
    }
}


