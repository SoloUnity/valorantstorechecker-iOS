//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var model:ContentModel
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
                            ForEach(0..<4) { value in
                                
                                Button {
                                    self.isDetailViewShowing = true
                                    
                                } label: {
                                    
                                    /*
                                     SkinCardView(skin: skin, priceTier: skin.contentTierUuid, vp:"500")
                                         .frame(height: (geo.size.height / 5.75))
                                     */
                                    
                                }
                                .sheet(isPresented: $isDetailViewShowing) {
                                    SkinCardDetailView()
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
