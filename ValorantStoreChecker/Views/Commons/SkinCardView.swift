//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    var skin:Skin
    var colour:Color = Color(red: 40/255, green: 40/255, blue: 40/255)
    var priceTier:String?
    var vp:String?

    
    var body: some View {
        
        
        ZStack{
            RectangleView(colour: colour)
                .shadow(color: .white, radius: 2)
                
            ZStack{
                
                WeaponImage(weapon: skin)
                    
                
                
                VStack{
                    // Price Tier
                    HStack{
                        // TODO: Price Tier
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


struct WeaponImage: View {
    var weapon: Skin
    var body: some View {
        
        HStack() {
            // https://developer.apple.com/documentation/swiftui/asyncimage
            if let displayIcon = weapon.displayIcon {
                AsyncImage(url: URL(string: "\(displayIcon)")) { phase in
                    if let image = phase.image {
                        image.resizable() // Displays the loaded image.
                    } else if phase.error != nil {
                        Image(systemName: "exclamationmark.icloud")
                            .frame(height: 250)// Indicates an error.
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
                .frame(height: 100)
            }
        
        } // vstack
    } // body
}
