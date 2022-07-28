//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation

class LoginModel: ObservableObject{
    
    @Published var storefront : [Skin] = []
    @Published var isAuthenticated: Bool = false
    @Published var token = ""
    @Published var riotEntitlement = ""
    @Published var puuid = ""
    @Published var region = "na"
    
    var username: String = ""
    var password: String = ""
    
    func login(){
        
        let defaults = UserDefaults.standard
        let webService = WebService()
        
        // TODO: Make this async/await instead of this dinosaur bozo shit
        
        
        webService.getCookies(){ result in
            switch result{
            case .success:
                // TODO: Implement saving cookies for reauthentication
                
                
                
                webService.getToken(username: self.username, password: self.password){ result in
                    switch result {
                        case .success(let token):
                            defaults.setValue(token, forKey: "token")
                        DispatchQueue.main.async {
                            self.token = token
                        }
                        webService.getRiotEntitlement(token: token) { result in
                            switch result{
                            case .success(let entitlement):
                                DispatchQueue.main.async {
                                    self.riotEntitlement = entitlement
                                }
                                
                                webService.getPlayerInfo(token: token) { result in
                                    switch result{
                                    case .success(let puuid):
                                        DispatchQueue.main.async {
                                            self.puuid = puuid
                                            self.isAuthenticated = true
                                        }
                                        
                                        webService.getStorefront(token: self.token, riotEntitlement: self.riotEntitlement, puuid: puuid, region: self.region) { result in
                                                    // TODO: Make this more efficient
                                                    switch result{
                                                    case .success(let storefront):
                                                        let skinModel = SkinModel()
                                                        for skin in skinModel.data{
                                                            for level in skin.levels!{
                                                                for item in storefront{
                                                                    if item == level.id.description.lowercased(){
                                                                        DispatchQueue.main.async {
                                                                            self.storefront.append(skin)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    case .failure(let error):
                                                        print(error.localizedDescription)
                                                    }
                                                }
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
        
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
       
    }
    
}
