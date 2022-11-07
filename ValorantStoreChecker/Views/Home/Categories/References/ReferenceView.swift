//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-11-06.
//

import SwiftUI

struct ReferenceView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        GeometryReader{ geo in
            
            
            VStack(spacing: 0){
                
                Logo()
                    .frame(width: geo.size.width/Constants.dimensions.logoSize)
                
                
                ScrollView(showsIndicators: false) {
                    
                    
                    
                    LazyVStack(spacing: 11) {}
                }
            }
            
        }
        .padding(.bottom, 1)
        .padding(.horizontal)
        
        
    }
}

struct ReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView()

    }
}
