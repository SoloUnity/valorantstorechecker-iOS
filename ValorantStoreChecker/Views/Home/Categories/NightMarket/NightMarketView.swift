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
                                            
                                            // TODO: percent off crashes sometimes, fix
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
                                    Button {
                                        // Scroll to top
                                        withAnimation { proxy.scrollTo("top", anchor: .top) }
                                        
                                    } label: {
                                        
                                        HStack{
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.up")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(15)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                        .frame(maxHeight: 50)
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
                                
                                //AdPaddingView()
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
            
            
            VStack {
                Spacer()
                
                CustomBannerView()
                    .padding(.horizontal)
            }
        }
        
        
        
    }
}
