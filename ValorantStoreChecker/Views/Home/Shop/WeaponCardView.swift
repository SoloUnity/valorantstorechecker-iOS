//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct WeaponCardView: View {
    
    var colour = Color.black
    
    var body: some View {
        ZStack{
            RectangleView(colour: colour)
                
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
                        
                        Text("4350")
                            .foregroundColor(.white)
                            .bold()
                        
                        Image("vp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            
                            
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
                WeaponCardView(colour: Color(red: 40/255, green: 40/255, blue: 40/255))
                .frame(height: (geo.size.height / 5.5))
                .padding()
                               
        }
    }
}
