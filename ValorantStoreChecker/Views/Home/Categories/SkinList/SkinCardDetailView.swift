//
//  WeaponCardDetailView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import SwiftUI
import AVKit
import AZVideoPlayer

struct SkinCardDetailView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @ObservedObject var skin:Skin
    @State var selectedLevel = 0
    @State var selectedChroma = 0
    @State var showAlert = false
    
    let player = AVPlayer()

    var body: some View {
        GeometryReader{ geo in
            
            VStack(alignment: .leading, spacing: 30){
                
                // MARK: Header
                HStack{
                    if skin.contentTierUuid != nil{
                        PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 30)
                    }else{
                        Image(systemName: "questionmark.circle")
                            .frame(width: 30, height: 30)
                    }
                    

                    Text (String(skin.displayName))
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
                
                // MARK: Price
                ZStack{
                    
                    RectangleView(colour: Constants.cardGrey)
                        .shadow(color: .white, radius: 2)
                    
                    HStack{
                        Text("Cost:")
                            .foregroundColor(.white)
                            .bold()
                        
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        if skin.contentTierUuid != nil {
                            Text(PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased() , contentTierUuid: skin.contentTierUuid!))
                                .foregroundColor(.white)
                                .bold()
                        }else{
                            Text("Unknown")
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                        Spacer()
                        
                        
                        if skin.contentTierUuid == nil || (skin.contentTierUuid != nil && PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased() , contentTierUuid: skin.contentTierUuid!) == "2475+"){
                            Button {
                               showAlert = true
                            } label: {
                                Image(systemName: "info.circle")
                                    .accentColor(.white)
                            }
                            .alert(isPresented: $showAlert) { () -> Alert in
                                        Alert(title: Text("The price of this skin is unfortunately not in our database."))
                                    }
                        }
                        

                    }
                    .padding()
                    
                    
                    
                    
                }
                .frame(height: 35)
                
                
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
                        
                        // Skin tier picker
                    if skin.levels!.count != 1{
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
                        
                    
                    
                }
                
                
                // MARK: Skin Variants / Chromas
                ZStack{
                    // Skin level images
                    RectangleView(colour: Constants.cardGrey)
                        .shadow(color: .white, radius: 2)
                    
                    if skin.chromas![selectedChroma].displayIcon != nil{
                        
                        AsyncImage(url: URL(string: skin.chromas![selectedChroma].displayIcon!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .padding()
                        
                    }
                    else if skin.chromas![selectedChroma].fullRender != nil{
                        
                        AsyncImage(url: URL(string: skin.chromas![selectedChroma].fullRender!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .padding()
                        
                    }
                }
                .frame(height: (geo.size.height / 5.75))
                
                if skin.chromas!.count != 1{
                    HStack{
                        Text("Variant")
                        Picker("Video Number", selection: $selectedChroma){
                            ForEach(0..<skin.chromas!.count, id: \.self){ chroma in
                                Text(String(chroma + 1))
                                    .tag(chroma)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accentColor(.red)
                    }
                }
                

                
            }
            .foregroundColor(.white)
            .padding()
        }
        .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
    }
}




/*
 if PriceTier.getPrice(contentTierUuid: skin.contentTierUuid!) == "2475+"{
 
 Button {
 showPopover.toggle()
 } label: {
 Image(systemName: "info.circle")
 .foregroundColor(.white)
 }
 .popover(isPresented: $showPopover) {
 Text("There is no known price database for exclusive tier skins.")
 }
 
 
 }
 */
