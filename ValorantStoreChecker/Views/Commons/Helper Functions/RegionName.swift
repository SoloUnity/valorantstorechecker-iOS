//
//  RegionName.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import Foundation
import Keychain
import SwiftUI

func getRegionKey() -> String {
    let keychain = Keychain()
    
    switch keychain.value(forKey: "region") as? String ?? "na" {
    case "na":
        
        return "Americas"

    case "eu":
        
        return "Europe"
        
    case "ap":
        
        return "AsiaPacific"

        
    case "kr":
        
        return "SouthKorea"
        
    default:
        return "Americas"
    }
}
