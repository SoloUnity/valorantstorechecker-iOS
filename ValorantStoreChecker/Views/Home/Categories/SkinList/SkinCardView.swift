//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    @EnvironmentObject var model:ContentModel
    @ObservedObject var skin:Skin
    
    var colour:Color = Color(red: 40/255, green: 40/255, blue: 40/255)
    var priceTier:String? = nil
    var vp:String? = nil

    
    var body: some View {
        
        
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
                    ProgressView()
                }
                    
                
                    
                VStack{
                    // Price Tier
                    HStack{
                        // TODO: Price Tier
                        if priceTier != nil{
                            ExclusiveEditionView()
                                .frame(width: 30, height: 30)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Price
                    HStack{
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
                        else{
                            Text(String(skin.displayName))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding()
                }
            }
        }
        
    }
}


