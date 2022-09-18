//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        GeometryReader{ geo in
            
            
            LazyVStack(spacing: 0){
                
                Logo()
                    .frame(width: geo.size.width/6.5)
                
                

                
                    
                
                ScrollView(showsIndicators: false) {
                    
                    
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        Task{
                            await authAPIModel.reload(skinModel: skinModel)
                        }
                    }
                    
                    
                    VStack(spacing: 11) {
                        
                        // Determine if the data has been fetched
                        if authAPIModel.storefront.isEmpty{
                            
                            ShopTopBarView(referenceDate: Date())
                            
                            HStack{
                                
                                Spacer()
                                
                                ProgressView()
                                
                                Spacer()
                                
                            }
                            
                        }
                        else{
                            
                            // MARK: Displayed elements
                            ShopTopBarView(referenceDate: defaults.object(forKey: "timeLeft") as? Date ?? Date())
                            
                            ForEach(authAPIModel.storefront) { skin in
                                
                                SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                    .frame(height: (UIScreen.main.bounds.height / 7.4))
                                
                            }
                            
                            ShopBottomBarView()
                            
                        }
                        
                    }
                    .padding(10)
                }
                .coordinateSpace(name: "pullToRefresh")
            }
            .padding(10)
        }
        
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .previewInterfaceOrientation(.portrait)
    }
}
