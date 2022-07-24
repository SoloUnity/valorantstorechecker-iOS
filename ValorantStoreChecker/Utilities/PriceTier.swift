//
//  PriceTier.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-23.
//

import Foundation

struct PriceTier{
    
    // Determine price of skin
    static func getPrice(contentTierUuid:String) -> String{
        switch contentTierUuid{
        case "12683d76-48d7-84a3-4e09-6985794f0445":
            return "875"
            
        case "0cebb8be-46d7-c12a-d306-e9907bfc5a25":
            return "1275"
            
        case "60bca009-4182-7998-dee7-b8a2558dc369":
            return "1775"
            
        case "411e4a55-4e59-7757-41f0-86a53f101bb5":
            return "2475"
            
        case "e046854e-406c-37f4-6607-19a9ba8426fc":
            return "2475+"
        
        default:
            return "Unknown"
   
        }
    }
}

