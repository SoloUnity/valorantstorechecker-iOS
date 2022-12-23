//
//  NightMarketView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-25.
//

import SwiftUI

struct NightMarketView: View {
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            
            
            GeometryReader{ geo in
                VStack(spacing: 0){
                    
                    ScrollViewReader{ (proxy: ScrollViewProxy) in
        
                        Logo()
                            .frame(width: geo.size.width/Constants.dimensions.logoSize)
                        
                        ScrollView(showsIndicators: false) {
                            
                            
                            LazyVStack(spacing: 11) {
                                ShopTopBarView(reloadType: "nightMarketReload", referenceDate: defaults.object(forKey: "nightTimeLeft") as? Date ?? Date())
                                
                                
                                ForEach(0..<authAPIModel.nightSkins.count, id: \.self) { index in
                                    
                                    if index < authAPIModel.percentOff.count || index < authAPIModel.nightSkins.count {
                                        
                                        if  (authAPIModel.percentOff.count != authAPIModel.nightSkins.count) {
                                            
                                            let percentOff = authAPIModel.percentOff[index]
                                            SkinCardView(skin: authAPIModel.nightSkins[index], showPrice: true, showPriceTier: true, price: authAPIModel.nightSkins[index].discountedCost ?? "" , originalPrice: false, percentOff: String(percentOff))
                                                .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                        }
                                        else {
                                            SkinCardView(skin: authAPIModel.nightSkins[index], showPrice: true, showPriceTier: true, price: authAPIModel.nightSkins[index].discountedCost ?? "" , originalPrice: false)
                                                .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                        }
                                        
                                    }
                                    
                                }
                                
                                if authAPIModel.nightSkins.count >= 5 {
                                    GoUpButton(proxy: proxy)
                                }
                                
                                
                            }
                            .id("top")
                            
                            
                            
                        }
                        .padding(.top, -8)
                        .refreshable {
                            
                            withAnimation(.easeIn(duration: 0.2)) {
                                authAPIModel.reloading = true
                            }
                            
                            Task{
                                await authAPIModel.reload(skinModel: skinModel, reloadType: "nightMarketReload")
                            }
                        }
                        


                    }
                }
                
                
            }
            .padding(.bottom, 1)
            .padding(.horizontal)
            
            
        }
        
        
        
    }
}
