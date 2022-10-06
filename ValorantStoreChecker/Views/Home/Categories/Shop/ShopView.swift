//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI
//import GoogleMobileAds

struct ShopView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        GeometryReader{ geo in
            
            
            VStack(spacing: 0){
                
                Logo()
                    .frame(width: geo.size.width/Constants.dimensions.logoSize)
                
                
                ScrollView(showsIndicators: false) {
                    
                    
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        Task{
                            await authAPIModel.reload(skinModel: skinModel, reloadType: "storeReload")
                        }
                    }
                    
                    
                    LazyVStack(spacing: 11) {
                        
                        // Determine if the data has been fetched
                        if authAPIModel.storefront.isEmpty{
                            
                            ShopTopBarView(reloadType: "storeReload", referenceDate: Date())
                            
                            
                            
                            HStack{
                                
                                Spacer()
                                
                                ProgressView()
                                
                                Spacer()
                                
                            }
                            
                        }
                        else{
                            
                            // MARK: Displayed elements
                            ShopTopBarView(reloadType: "storeReload", referenceDate: defaults.object(forKey: "timeLeft") as? Date ?? Date())
                            
                            ForEach(authAPIModel.storefront) { skin in
                                
                                SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                    .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                
                            }
                            
                            //CustomBannerView()
                            
                            ShopBottomBarView()
                            
                            
                            
                            
                        }
                        
                    }
                }
                .coordinateSpace(name: "pullToRefresh")
            }
            
        }
        .padding(.bottom, 1)
        .padding(.horizontal)
        
        
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .previewInterfaceOrientation(.portrait)
    }
}
