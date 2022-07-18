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
            RectangleView(colour: colour)
                .shadow(color: Color(red: 235/255, green: 152/255, blue: 100/255), radius: 5, x: 3, y: 3)
                
            ZStack{
                Image("knife")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                
                VStack{
                    HStack{
                        Image("orange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
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
