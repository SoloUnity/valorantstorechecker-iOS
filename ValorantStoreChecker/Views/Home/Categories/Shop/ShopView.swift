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
    

        var body: some View {
                
            GeometryReader{ geo in
    
                
                VStack{
                    
                    LogoView()
                        .frame(width: geo.size.width/4)
                    
                    
                    ScrollView{
                        VStack(spacing: 13) {
                            
                            // Display ShopStuff
                            if authAPIModel.storefront.isEmpty{
                                
                                VStack{
                                    Spacer()
                                    
                                    HStack{
                                        
                                        Spacer()
                                        
                                        ProgressView()
                                        
                                        Spacer()
                                        
                                    }
                                    
                                    Spacer()
                                }
                                
                            }
                            else{
                                
                                ForEach(authAPIModel.storefront) { skin in
                                    
                                    SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                        .frame(height: (UIScreen.main.bounds.height / 6.5))
                                    
                                }
                            }
                            
                        }
                        .padding(10)
                    }
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
