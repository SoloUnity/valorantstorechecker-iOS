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
    
    struct URL {
        // API Stuff
        static var valStore = "https://s3.valorantstore.net/"
        static var valAPIMedia = "https://media.valorant-api.com/"
        static var valAPISkins = "https://valorant-api.com/v1/weapons/skins"
        static var auth = "https://auth.riotgames.com/api/v1/authorization"
        static var entitlement = "https://entitlements.auth.riotgames.com/api/token/v1"
        static var playerInfo = "https://auth.riotgames.com/userinfo"
        static var cookieReauth = "https://auth.riotgames.com/authorize?redirect_uri=https%3A%2F%2Fplayvalorant.com%2Fopt_in&client_id=play-valorant-web-prod&response_type=token%20id_token&nonce=1"
        
        // About page stuff
        static var supportTicket = "https://discord.com/channels/781946764168658984/983281981368467486"
        static var faq = "https://github.com/SoloUnity/Valorant-Store-Checker-App/blob/main/README.md#frequently-asked-questions"
        static var sourceCode = "https://github.com/SoloUnity/Valorant-Store-Checker-App"
        static var website = "https://valorantstore.net"
        static var discord = "https://discord.gg/vK5mzjvqYM"
        static var review = "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review"
        static var donate = "https://paypal.me/SoloUnityNA1?country.x=CA&locale.x=en_US"
        static var julian = "https://github.com/juliand665"
        static var lunac = "https://github.com/Lunac-dev"
        static var privacy = "https://solounity.notion.site/solounity/Valorant-Store-Checker-App-Privacy-Policy-761932ab3fcb4fea95564b2b63d2d5b5"
        
    }
    
    struct dimensions {
        static var onboardingLogoSize : CGFloat = 4
        static var circleButtonSize : CGFloat = 60
    }
    
}

