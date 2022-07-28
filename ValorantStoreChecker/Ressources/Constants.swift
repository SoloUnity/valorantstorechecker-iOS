//
//  Constants.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-20.
//

import Foundation
import SwiftUI

struct Constants{
    static var bgGradient = Gradient(colors:[Color(red: 28/255, green: 28/255, blue: 30/255), Color(red: 28/255, green: 28/255, blue: 30/255), .pink])
    
    struct URL{
        static var valStore = "https://s3.valorantstore.net/"
        static var auth = "https://auth.riotgames.com/api/v1/authorization"
        static var entitlement = "https://entitlements.auth.riotgames.com/api/token/v1"
        static var playerInfo = "https://auth.riotgames.com/userinfo"
    }
}

