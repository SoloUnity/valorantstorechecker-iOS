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
    var showPrice = false
    var showPriceTier = false
    var price = ""

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
                        
                        Spacer()
                        
                        // Price
                        HStack{
                            if skin.contentTierUuid != nil && showPriceTier{
                                PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 18)
                            }
                            else{
                                Image(systemName: "questionmark.circle")
                                    .frame(width:10, height: 10)
                            }
                            
                            Text(String(skin.displayName))
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .bold()
                                .shadow(color:.black, radius: 10)
                                
                            
                            
                            Spacer()
                            
                            if showPrice{
                                Image("vp")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                
                                if skin.contentTierUuid != nil{
                                    Text(PriceTier.getLocalPrice(contentTierUuid: skin.contentTierUuid!))
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                else{
                                    Text("Unknown")
                                }
                                
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
