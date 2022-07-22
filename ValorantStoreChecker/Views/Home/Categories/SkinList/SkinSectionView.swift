//
//  SkinSectionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-21.
//

import SwiftUI

struct SkinSectionView: View {
    
    var skins: [Skin]
    
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 13){
                
                Text(" Hello")
                
                ForEach(skins){ skin in
                    NavigationLink(destination: SkinCardDetailView()) {
                        SkinCardView(skin: skin)
                        
                    }
                }
            }
        }
        
        
        
    }
}


