//
//  PriceTierView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-23.
//

import SwiftUI

struct PriceTierView: View {
    
    var contentTierUuid:String
    var dimensions:Int
    
    var body: some View {
        switch contentTierUuid{
        case "12683d76-48d7-84a3-4e09-6985794f0445":
            SelectEditionView()
                .frame(width: CGFloat(dimensions), height: CGFloat(dimensions))
            
        case "0cebb8be-46d7-c12a-d306-e9907bfc5a25":
            DeluxeEditionView()
                .frame(width: CGFloat(dimensions), height: CGFloat(dimensions))
            
        case "60bca009-4182-7998-dee7-b8a2558dc369":
            PremiumEditionView()
                .frame(width: CGFloat(dimensions), height: CGFloat(dimensions))
            
        case "411e4a55-4e59-7757-41f0-86a53f101bb5":
            UltraEditionView()
                .frame(width: CGFloat(dimensions), height: CGFloat(dimensions))
            
        case "e046854e-406c-37f4-6607-19a9ba8426fc":
            ExclusiveEditionView()
                .frame(width: CGFloat(dimensions), height: CGFloat(dimensions))
        
        default:
            EmptyView()
            
        }
    }
}

