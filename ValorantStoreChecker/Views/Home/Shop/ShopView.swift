//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    @State var tabIndex = 1
    

        var body: some View {
                
            GeometryReader{ geo in
                
                
                VStack{
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/4)
                        .padding(.bottom)
                    
                    
                    ScrollView{
                        VStack(spacing: 10) {
                            ForEach(0..<4) { value in
                                    WeaponCardView(colour: Color(red: 40/255, green: 40/255, blue: 40/255))
                                    .frame(height: (geo.size.height / 5.5))
                                    
                                        
                            }
                        }
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
