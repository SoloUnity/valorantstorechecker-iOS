//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    @EnvironmentObject var model:SkinModel
    @ObservedObject var skin:Skin
    @State var isDetailViewShowing = false
    
    var colour:Color = Color(red: 40/255, green: 40/255, blue: 40/255)
    var vp:String? = nil
    var showPriceTier = false

    var body: some View {
        
        Button {
            isDetailViewShowing = true
        } label: {
            ZStack{
                RectangleView(colour: colour)
                    .shadow(color: .white, radius: 2)
                    
                ZStack{
                    
                    
                    // Image from json
                    if skin.imageData != nil{
                        let uiImage = UIImage(data: skin.imageData ?? Data())
                                        
                        Image(uiImage: uiImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    else{
                        // Quicker load time but a data muncher
                        AsyncImage(url: URL(string: skin.levels!.first!.displayIcon!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .padding()
                    }
                     
                    
                    
                        
                    VStack{
                        // Price Tier
                        HStack{
                            if showPriceTier{
                                PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 30)
                            }

                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                        
                        // Price
                        HStack{
                            
                            
                            Text(String(skin.displayName))
                                .foregroundColor(.white)
                                .bold()
                                .shadow(color:.black, radius: 3)
                                .font(.caption)
                            
                            
                            Spacer()
                            
                            if vp != nil{
                                Image("vp")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)
                                
                                Text("4350")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            
                        }
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $isDetailViewShowing) {
            SkinCardDetailView(skin: skin)
                .preferredColorScheme(.dark)
        }
        
    }
}
