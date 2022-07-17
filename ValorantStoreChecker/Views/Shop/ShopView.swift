//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ShopView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let gradient = Gradient(colors: [.black, .black, .pink])
    

        var body: some View {
                
            GeometryReader{ geo in
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/4)
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns) {
                        ForEach(0..<4) { value in
                                WeaponCardView(colour: Color(red: 31/255, green: 30/255, blue: 30/255))
                                .frame(width: (geo.size.width / 2) - 20, height: (geo.size.height / 2) - 100)
                                    
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                
                
                 
            }
            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            
            
            
        }

        private func emoji(_ value: Int) -> String {
            guard let scalar = UnicodeScalar(value) else { return "?" }
            return String(Character(scalar))
        }
    }

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .previewInterfaceOrientation(.portrait)
    }
}
