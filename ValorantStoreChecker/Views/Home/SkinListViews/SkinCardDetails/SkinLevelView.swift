//
//  SkinVideoView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-23.
//

import SwiftUI
import AVKit
import AZVideoPlayer

struct SkinLevelView: View {
    
   
    
    var body: some View {
        
        if skin.levels!.count != 1{
            // MARK: Skin tier videos
            // Skin Video Player
            if skin.levels![selectedLevel].streamedVideo != nil{
                
                //let url = URL(string: skin.levels![selectedLevel].streamedVideo!)
                
                AZVideoPlayer(player: player)
                    .cornerRadius(10)
                    .aspectRatio(CGSize(width: 1920, height: 1080), contentMode: .fit)
                    .shadow(color: .white, radius: 2)
                    .onAppear{
                          if player.currentItem == nil {
                              //"\(Constants.apiUrl)streamedVideo/\(skin.levels!.last!.id.description.lowercased()).mp4"
                              
                              let item = AVPlayerItem(url: URL(string: skin.levels![selectedLevel].streamedVideo!)!)
                              player.replaceCurrentItem(with: item)
                              
                            }
                        
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                player.play() // Autoplay
                            })
                         
                         
                    }
                    .onChange(of: selectedLevel) { level in
                        let item = AVPlayerItem(url: URL(string: skin.levels![level].streamedVideo!)!)
                        player.replaceCurrentItem(with: item)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            player.play() // Autoplay
                        })
                    }
            }
            
            
            // Skin tier picker
            HStack{
                Text("Tier")
                Picker("Video Number", selection: $selectedLevel){
                    ForEach(0..<skin.levels!.count, id: \.self){ level in
                        
                        
                        Text(String(level + 1))
                            .tag(level)
                        
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        else{
            ZStack{
                RectangleView(colour: Color(red: 40/255, green: 40/255, blue: 40/255))
                    .shadow(color: .white, radius: 2)
                
                // Price
                HStack{
                    Image(systemName: "exclamationmark.circle")
                    Text("No videos are available for this skin.")
                }
                .foregroundColor(.white)
                .padding()

            }
            .padding(.vertical)
            .frame(height: 30)
            
        }
    }
}


