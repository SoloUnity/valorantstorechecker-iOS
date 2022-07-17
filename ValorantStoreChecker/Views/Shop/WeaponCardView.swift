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
                
            
            Image("valorant-singularity-phantom-skin Small")
                .resizable()
                .scaledToFit()
                .padding()
        }
        
        
        
    }
}

struct WeaponCardView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponCardView()
    }
}
