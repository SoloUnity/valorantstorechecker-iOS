//
//  PriceTier.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-23.
//

import Foundation

struct PriceTier{
    
    static func getRemotePrice(authAPIModel: AuthAPIModel ,uuid : String) -> String {
        
        for skin in authAPIModel.storePrice {
            if uuid == skin.offerID && skin.cost != nil{
                return String(skin.cost!.price)
            }
        }
        
        return "Unknown"
    }
}

