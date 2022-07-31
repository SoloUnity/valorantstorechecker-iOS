//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    @State var tabIndex = 1
    @State var isDetailViewShowing = false
    
    let defaults = UserDefaults.standard

        var body: some View {
                
            GeometryReader{ geo in
    
                
                VStack{
                    
                        
                    LogoView()
                        .frame(width: geo.size.width/4)
                                  
                    ScrollView(showsIndicators: false) {
                        
                        
                        PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                            Task{
                                await authAPIModel.login()
                            }
                        }
                        
                        
                        VStack(spacing: 13) {
                            
                            ShopTopBarView(referenceDate: defaults.object(forKey: "timeLeft") as? Date ?? Date())
                            
                            // Display ShopStuff
                            if authAPIModel.storefront.isEmpty{
                                
                                HStack{
                                    
                                    Spacer()
                                    
                                    ProgressView()
                                    
                                    Spacer()
                                    
                                }
                                
                            }
                            else{
                                
                                ForEach(authAPIModel.storefront) { skin in
                                    
                                    SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                        .frame(height: (UIScreen.main.bounds.height / 7.4))
                                    
                                }
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
