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
    @ObservedObject var skin:Skin
    @State var showAlert = false
    var price = ""
    
    var body: some View {
        
        // MARK: Price
        HStack{
            
            if skin.contentTierUuid != nil {
                let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                
                if price != "Unknown" {
                    
                    if skin.contentTierUuid == nil || (skin.contentTierUuid != nil && PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased()) == "2475+") {
                        
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
                        .bold()
                    
                    Spacer()
                    
                    if self.price != "" {
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(self.price)
                            .foregroundColor(.white)
                            .bold()
                    }
                    else {
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(price)
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    
                }
                else{
                    
                    Text(LocalizedStringKey("ExclusiveSkinMessage"))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            else{
                
                Text(LocalizedStringKey("ExclusiveSkinMessage"))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
        }
        .padding()

        
    }
}

