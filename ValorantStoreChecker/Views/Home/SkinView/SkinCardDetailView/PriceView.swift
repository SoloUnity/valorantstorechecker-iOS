//
//  PriceView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct PriceView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var alertModel : AlertModel
    @ObservedObject var skin:Skin
    var price = ""
    
    var body: some View {
        
        // MARK: Price
        HStack{
            
            if skin.contentTierUuid != nil {
                let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                
                if price != "Unknown" {
                    
                    if skin.contentTierUuid == nil || (skin.contentTierUuid != nil && PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased()) == "2475+") {
                        
                        Button {
                            alertModel.alertPriceInfo = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    Text(LocalizedStringKey("Cost"))
                        .bold()
                    
                    Spacer()
                    
                    if self.price != "" {
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(self.price)
                            .bold()
                    }
                    else {
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(price)
                            .bold()
                    }
                    
                    
                }
                else{
                    
                    Text(LocalizedStringKey("ExclusiveSkinMessage"))
                    
                    Spacer()
                }
            }
            else{
                
                Text(LocalizedStringKey("ExclusiveSkinMessage"))
                
                Spacer()
            }
            
        }
        .padding()

        
    }
}

