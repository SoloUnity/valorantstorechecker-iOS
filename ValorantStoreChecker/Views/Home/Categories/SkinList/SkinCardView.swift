//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    @EnvironmentObject var skinModel : SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @ObservedObject var skin:Skin
    @State var isDetailViewShowing = false

    var showPrice = false
    var showPriceTier = false
    var price = ""

    var body: some View {
        
        Button {
            isDetailViewShowing = true
        } label: {
            
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
                    
                    HStack{
                        
                        // Price Tier Icon
                        if skin.contentTierUuid != nil && showPriceTier{
                            PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 18)
                        }
                        else{
                            Image(systemName: "questionmark.circle")
                                .frame(width:10, height: 10)
                                .foregroundColor(.white)
                                .shadow(color: .white, radius: 1)
                        }
                        
                        // Skin Name
                        Text(String(skin.displayName))
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .bold()
                            .shadow(color: .black, radius: 3)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        // Price
                        if showPrice{
                            Image("vp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .shadow(color: .white, radius: 2)
                            
                            if skin.contentTierUuid != nil {
                                Text(PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased() , contentTierUuid: skin.contentTierUuid!))
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .bold()
                                    .shadow(color: .black, radius: 3)
                                
                            }else{
                                Text("Unknown")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        
                    }
                    .padding(10)
                }
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
            
        }
        
        .sheet(isPresented: $isDetailViewShowing) {
            SkinCardDetailView(skin: skin)
                .preferredColorScheme(.dark)
        }
        
    }
}
