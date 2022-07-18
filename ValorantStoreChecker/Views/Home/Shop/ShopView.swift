//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    @State var tabIndex = 1
    @State var isDetailViewShowing = false
    

        var body: some View {
                
            GeometryReader{ geo in
                

                VStack{
                    
                    LogoView()
                        .frame(width: geo.size.width/4)
                    
                    
                    ScrollView{
                        VStack(spacing: 13) {
                            ForEach(0..<4) { value in
                                
                                Button {
                                    self.isDetailViewShowing = true
                                    
                                } label: {
                                    SkinCardView(colour: Color(red: 40/255, green: 40/255, blue: 40/255))
                                        .frame(height: (geo.size.height / 5.75))
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
