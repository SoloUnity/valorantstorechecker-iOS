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
                
                // MARK: Title header
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
                
                    
                    HStack{
                        
                        if skin.contentTierUuid == nil || (skin.contentTierUuid != nil && PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased() , contentTierUuid: skin.contentTierUuid!) == "2475+") {
                            Button {
                               showAlert = true
                            } label: {
                                Image(systemName: "info.circle")
                                    .accentColor(.white)
                            }
                            .alert(isPresented: $showAlert) { () -> Alert in
                                        Alert(title: Text(LocalizedStringKey("InfoPrice")))
                                    }
                        }
                        
                        Text(LocalizedStringKey("Cost"))
                            .foregroundColor(.white)
                            .bold()
                        
                        Spacer()
                        
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        if skin.contentTierUuid != nil {
                            Text(PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased() , contentTierUuid: skin.contentTierUuid!))
                                .foregroundColor(.white)
                                .bold()
                        }else{
                            Text(LocalizedStringKey("Unknown"))
                                .foregroundColor(.white)
                                .bold()
                        }
                        

                    }
                    .padding()
                    
                    
                    
                    
                }
                .background(Blur(radius: 25, opaque: true))
                .cornerRadius(10)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 3)
                        .offset(y: -1)
                        .offset(x: -1)
                        .blendMode(.overlay)
                        .blur(radius: 0)
                        .mask {
                            RoundedRectangle(cornerRadius: 10)
                        }
                }
                .frame(height: 35)
                
                
                // MARK: Skin tier videos
                if skin.levels![selectedLevel].streamedVideo != nil{
                    
                        AZVideoPlayer(player: player)
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 1920, height: 1080), contentMode: .fit)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 60/255, green: 60/255, blue: 60/255), lineWidth: 3)
                                    .offset(y: -1)
                                    .offset(x: -1)
                                    .blendMode(.overlay)
                                    .blur(radius: 0)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 10)
                                    }
                            }
                                    
                            .onAppear{
                                if player.currentItem == nil {
                                    
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
                        
                    // MARK: Video Tier Picker
                    if skin.levels!.count != 1{
                        
                        HStack{
                            HStack {
                                Text(LocalizedStringKey("Tier"))
                                Text(String(selectedLevel + 1))
                                    .padding(-4)
                            }

                            
                            Spacer()
                            
                            Picker("Video Number", selection: $selectedLevel){
                                ForEach(0..<skin.levels!.count, id: \.self){ level in
                                    
                                    Text(cleanLevelName(name: String(skin.levels![level].levelItem ?? "Default")))
                                        .tag(level)
                                    
                                }
                            }
                            .padding(.horizontal, 8)
                            .accentColor(.white)
                            .pickerStyle(MenuPickerStyle())
                            .background(.ultraThinMaterial)
                            .cornerRadius(7)
 
                        }
                        .padding()
                        .background(Blur(radius: 25, opaque: true))
                        .cornerRadius(10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 3)
                                .offset(y: -1)
                                .offset(x: -1)
                                .blendMode(.overlay)
                                .blur(radius: 0)
                                .mask {
                                    RoundedRectangle(cornerRadius: 10)
                                }
                        }
                    }
                }
                
                
                // MARK: Skin Variants / Chromas
                HStack{
                    Spacer()
                    
                    if let imageData = UserDefaults.standard.data(forKey: skin.chromas![selectedChroma].id.description) {
                        
                        let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
                        
                        let uiImage = UIImage(data: decoded)
                        
                        Image(uiImage: uiImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                    }
                    else if skin.chromas![selectedChroma].displayIcon != nil{
                        
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
                    

                    Spacer()
                }
                .frame(height: (UIScreen.main.bounds.height / 6.5))
                .background(Blur(radius: 25, opaque: true))
                .cornerRadius(10)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 3)
                        .offset(y: -1)
                        .offset(x: -1)
                        .blendMode(.overlay)
                        .blur(radius: 0)
                        .mask {
                            RoundedRectangle(cornerRadius: 10)
                        }
                }
                .frame(height: (geo.size.height / 5.75))
                
                // MARK: Skin Chroma Picker
                if skin.chromas!.count != 1{
                    HStack{
                        Text(LocalizedStringKey("Variant"))
                        
                        Spacer()
                        
                        Picker("Video Number", selection: $selectedChroma){
                            ForEach(0..<skin.chromas!.count, id: \.self){ chroma in
                                Text(cleanChromaName(name: (skin.chromas![chroma].displayName ?? "Default")))
                                    .tag(chroma)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accentColor(.red)
                        
                    }
                    .padding()
                    .background(Blur(radius: 25, opaque: true))
                    .cornerRadius(10)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 3)
                            .offset(y: -1)
                            .offset(x: -1)
                            .blendMode(.overlay)
                            .blur(radius: 0)
                            .mask {
                                RoundedRectangle(cornerRadius: 10)
                            }
                    }
                }
            }
            .foregroundColor(.white)
            .padding()
        }
        .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
    }
}


// MARK: Helper Functions
func cleanLevelName(name : String) -> String {
    
    if name == "Default"{
        return "Default"
    }else{
        let nameList = name.split(separator: ":")
        
        guard let last = nameList.last else{
            return "Unknown"
        }
        
        // Check if all string is uppercased
        if last == last.uppercased(){
            return String(last)
        }else{
            // Split into list of individual letters
            var characters = last.map{ String($0) }
            
            var count = 0
            
            // Insert space before Capital letters
            for letter in characters {
                
                if letter == letter.uppercased(){
                    characters.insert(" ", at: count)
                    count += 1
                }
                count += 1
                
            }

            // Assemble into string
            var finalString = ""
            
            for item in characters {
                finalString += item
            }
            
            return finalString.trimmingCharacters(in: .whitespaces)
        }
    }
}

func cleanChromaName(name: String) -> String {
    
    if name == "Default" {
        return "Default"
    }else{
        
        // Remove irrelevant information
        if name.contains("(") {
            let bracket1 = name.split(separator: "(")
            let bracket2 = bracket1[1].split(separator: ")")
            var nameList = bracket2[0].split(separator: " ")
            nameList.removeFirst()
            nameList.removeFirst()
            
            var finalString = ""
            
            for item in nameList {
                finalString += item
            }
            
            return finalString
        }
        else{
            return "Default"
        }
    }
}


