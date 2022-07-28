//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var loginModel:LoginModel
    @State var tabIndex = 1
    @State var isDetailViewShowing = false
    

        var body: some View {
                
            GeometryReader{ geo in
                

                VStack{
                    
                    LogoView()
                        .frame(width: geo.size.width/4)
                    
                    
                    ScrollView{
                        VStack(spacing: 13) {
                            // Shop stuff
                            if loginModel.storefront.isEmpty{
                                ProgressView()
                            }
                            else{
                                ForEach(loginModel.storefront) { skin in
                                    
                                    Button {
                                        self.isDetailViewShowing = true
                                        
                                    } label: {
                                        
                                        SkinCardView(skin: skin, showPriceTier: true)
                                            .frame(height: (geo.size.height / 5.75))
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        .padding(10)
                    }
                    
                    
                }
                .padding()
            }
            
        }
    }

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .previewInterfaceOrientation(.portrait)
    }
}
