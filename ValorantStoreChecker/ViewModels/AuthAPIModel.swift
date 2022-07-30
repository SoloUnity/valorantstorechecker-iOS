//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation

class AuthAPIModel: ObservableObject {
    
    @Published var storefront : [Skin] = []
    @Published var isAuthenticated: Bool = false
    @Published var token = ""
    @Published var riotEntitlement = ""
    @Published var puuid = ""
    @Published var region = "na"
    
    var username: String = ""
    var password: String = ""
    
    @MainActor
    func login() async{
        
        let defaults = UserDefaults.standard
        
        do{
            
            try await WebService.getCookies()
            let token = try await WebService.getToken(username: self.username, password: self.password)
            self.token = token
            let riotEntitlement = try await WebService.getRiotEntitlement(token: token)
            self.riotEntitlement = riotEntitlement
            let puuid = try await WebService.getPlayerInfo(token: token)
            self.puuid = puuid
            let storefront = try await WebService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: self.region)
            
            let skinModel = SkinModel()
            
            for skin in skinModel.data{
                for level in skin.levels!{
                    for item in storefront{
                        if item == level.id.description.lowercased(){
                            self.storefront.append(skin)
                        }
                    }
                }
            }
            
            //let storePrices = try await WebService.getStorePrices(token: token, riotEntitlement: riotEntitlement, region: self.region)
            self.isAuthenticated = true
            
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func signout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
       
    }
    
}
