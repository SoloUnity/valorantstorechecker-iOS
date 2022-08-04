//
//  WishListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct WishListView: View {
    
    @EnvironmentObject var model:SkinModel
    var body: some View {
        GeometryReader{ geo in
            
            
            LazyVStack(spacing: 0){
                
                
                Logo()
                    .padding(80)
                
                
            }
            .padding(10)
        }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
    }
}
