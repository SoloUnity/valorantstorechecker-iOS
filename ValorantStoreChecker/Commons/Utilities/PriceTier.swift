//
//  PriceTier.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-23.
//

import Foundation

struct PriceTier{
    
    static func getRemotePrice(authAPIModel: AuthAPIModel ,uuid : String) -> String {
        
        if authAPIModel.storePrice[uuid]?.cost?.price != nil {
            return String((authAPIModel.storePrice[uuid]?.cost!.price)!)
        }
        else {
            return "Unknown"
        }
        
    }
    
}
