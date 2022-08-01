//
//  Constants.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-20.
//

import Foundation
import SwiftUI

struct Constants{
    static var bgGradient = Gradient(colors:[Color(red: 20/255, green: 20/255, blue: 20/255), Color(red: 28/255, green: 28/255, blue: 30/255), .pink])
    static var bgGrey = Color(red: 28/255, green: 28/255, blue: 30/255)
    static var cardGrey = Color(red: 40/255, green: 40/255, blue: 40/255)
    
    struct URL{
        static var valStore = "https://s3.valorantstore.net/"
        static var auth = "https://auth.riotgames.com/api/v1/authorization"
        static var entitlement = "https://entitlements.auth.riotgames.com/api/token/v1"
        static var playerInfo = "https://auth.riotgames.com/userinfo"
        static var cookieReauth = "https://auth.riotgames.com/authorize?redirect_uri=https%3A%2F%2Fplayvalorant.com%2Fopt_in&client_id=play-valorant-web-prod&response_type=token%20id_token&nonce=1"
    }
}

