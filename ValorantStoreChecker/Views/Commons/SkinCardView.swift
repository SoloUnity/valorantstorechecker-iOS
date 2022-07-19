//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    var colour = Color.black
    
    var body: some View {
        ZStack{
            RectangleView(colour: Color.black)
                .shadow(color: .white, radius: 2)
                
            ZStack{
                
                // Skin Image
                Image("knife")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                
                VStack{
                    // Price Tier
                    HStack{
                        ExclusiveEditionView()
                            .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Price
                    HStack{
                        Spacer()
                        
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                        
                        Text("4350")
                            .foregroundColor(.white)
                            .bold()

                    }
                    .padding()
                    
                }
            }
            
        }
        
    }
}

struct WeaponCardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geo in
                SkinCardView(colour: Color(red: 40/255, green: 40/255, blue: 40/255))
                .frame(height: (geo.size.height / 5.5))
                .padding()
                               
        }
    }
}
