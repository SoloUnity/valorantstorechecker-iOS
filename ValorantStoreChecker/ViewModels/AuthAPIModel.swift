//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation
import Keychain

class AuthAPIModel: ObservableObject {
    
    @Published var keychain = Keychain()
    @Published var defaults = UserDefaults.standard
    
    @Published var storefront : [Skin] = []
    @Published var storePrice : [Offer] = []
    
    
    @Published var isAuthenticated: Bool = false
    @Published var isAuthenticating : Bool = false
    @Published var failedLogin : Bool = false
    
    
    @Published var reloading : Bool = false
    
    @Published var showMultifactor : Bool = false
    @Published var enteredMultifactor : Bool = false
    
    @Published var email : String = ""
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var multifactor : String = ""

    init() {
        
        // TODO: Learn coredata and not do this bozo shit
        if let objects = defaults.value(forKey: "storefront") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Skin] {
                DispatchQueue.main.async{
                    self.storefront = objectsDecoded
                }
            }
        }
        
        if let objects = defaults.value(forKey: "storePrice") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Offer] {
                DispatchQueue.main.async{
                    self.storePrice = objectsDecoded
                }
            }
        }
    }
    
    @MainActor
    func login() async{

        do{
            
            // Save the username for further display
            if defaults.string(forKey: "username") == nil{
                defaults.set(self.username, forKey: "username")
            }
            
            try await WebService.getCookies()
            let tokenList = try await WebService.getToken(username: defaults.string(forKey: "username") ?? "", password: self.password)
            
            
            if tokenList.count == 2 {
                self.email = tokenList[1]
                self.showMultifactor = true
                self.isAuthenticating = false
            }
            else{
                let token = tokenList[0]
                await loginHelper(token: token)
            }
            
            
            
        }catch{
            self.isAuthenticating = false
            self.failedLogin = true
            self.username = ""
            self.password = ""
            
            defaults.removeObject(forKey: "username")
            defaults.removeObject(forKey: "authentication")
            defaults.removeObject(forKey: "storefront")
            defaults.removeObject(forKey: "storePrice")
            let _ = keychain.remove(forKey: "ssid")
            let _ = keychain.remove(forKey: "tdid")
            
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func loginHelper(token : String) async {
        do {
            self.password = String(repeating: "a", count: (self.password.count)) // Clear password from memory and put in a placeholder
            let riotEntitlement = try await WebService.getRiotEntitlement(token: token)
            let puuid = try await WebService.getPlayerInfo(token: token)
            let storefront = try await WebService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: defaults.string(forKey: "region") ?? "na")
            let wallet = try await WebService.getWallet(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: defaults.string(forKey: "region") ?? "na")
            
            self.defaults.set(wallet[0], forKey: "vp")
            self.defaults.set(wallet[1], forKey: "rp")
            
            var tempStore : [Skin] = []
            
            for skin in SkinModel().data{
                for level in skin.levels!{
                    for item in storefront.SingleItemOffers!{
                        if item == level.id.description.lowercased(){
                            tempStore.append(skin)
                        }
                    }
                }
            }

            self.storefront = tempStore
            
            let storefrontEncoder = JSONEncoder()
            if let encoded = try? storefrontEncoder.encode(tempStore){
                defaults.set(encoded, forKey: "storefront")
            }
            
            let storePrice = try await WebService.getStorePrices(token: token, riotEntitlement: riotEntitlement, region: defaults.string(forKey: "region") ?? "na")
            
            self.storePrice = storePrice
            
            let priceEncoder = JSONEncoder()
            if let encoded = try? priceEncoder.encode(storePrice){
                defaults.set(encoded, forKey: "storePrice")
            }
            
            let referenceDate = Date() + Double(storefront.SingleItemOffersRemainingDurationInSeconds ?? 0)
            
            defaults.set(referenceDate, forKey: "timeLeft")
            
            self.isAuthenticating = false
            self.reloading = false
            self.isAuthenticated = true
            defaults.set(self.isAuthenticated, forKey: "authentication")
            
            self.username = ""
            self.password = ""
            self.multifactor = ""
            
        }catch {
            self.isAuthenticating = false
            self.failedLogin = true
            self.username = ""
            self.password = ""
            
            defaults.removeObject(forKey: "username")
            defaults.removeObject(forKey: "authentication")
            defaults.removeObject(forKey: "storefront")
            defaults.removeObject(forKey: "storePrice")
            let _ = keychain.remove(forKey: "ssid")
            let _ = keychain.remove(forKey: "tdid")
            
            print(error.localizedDescription)
        }
        
    }
    
    @MainActor
    func multifactor() async {
        if enteredMultifactor{
            do{
                let token = try await WebService.multifactor(code: self.multifactor)
                await loginHelper(token: token)
                self.showMultifactor = false
                self.enteredMultifactor = false
            }
            catch{
                self.enteredMultifactor = false
                self.multifactor = ""
                self.password = ""
                
                self.isAuthenticating = false
                self.failedLogin = true
                
                
                defaults.removeObject(forKey: "username")
                defaults.removeObject(forKey: "authentication")
                defaults.removeObject(forKey: "storefront")
                defaults.removeObject(forKey: "storePrice")
                let _ = keychain.remove(forKey: "ssid")
                let _ = keychain.remove(forKey: "tdid")

            }
            
        }
        
    }
    
    @MainActor
    func reload() async {
        do{
            
            let token = try await WebService.cookieReauth()
            let riotEntitlement = try await WebService.getRiotEntitlement(token: token)
            let puuid = try await WebService.getPlayerInfo(token: token)
            let storefront = try await WebService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: defaults.string(forKey: "region") ?? "na")
            let wallet = try await WebService.getWallet(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: defaults.string(forKey: "region") ?? "na")
            
            self.defaults.set(wallet[0], forKey: "vp")
            self.defaults.set(wallet[1], forKey: "rp")
            
            let skinModel = SkinModel()
            
            var tempStore : [Skin] = []
            
            for skin in skinModel.data{
                for level in skin.levels!{
                    for item in storefront.SingleItemOffers!{
                        if item == level.id.description.lowercased(){
                            tempStore.append(skin)
                        }
                    }
                }
            }

            self.storefront = tempStore
            
            let storefrontEncoder = JSONEncoder()
            if let encoded = try? storefrontEncoder.encode(tempStore){
                defaults.set(encoded, forKey: "storefront")
            }
            
            let storePrice = try await WebService.getStorePrices(token: token, riotEntitlement: riotEntitlement, region: defaults.string(forKey: "region") ?? "na")
            
            self.storePrice = storePrice
            
            let priceEncoder = JSONEncoder()
            if let encoded = try? priceEncoder.encode(storePrice){
                defaults.set(encoded, forKey: "storePrice")
            }
            
            let referenceDate = Date() + Double(storefront.SingleItemOffersRemainingDurationInSeconds ?? 0)
            
            defaults.set(referenceDate, forKey: "timeLeft")
            
            self.reloading = false
            
            
            
        }catch{

            self.reloading = false
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func signout() {
        // Create a new session
        WebService.session = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = 30 // seconds
            configuration.timeoutIntervalForResource = 30 // seconds
            return URLSession(configuration: configuration)
        }()
        // Reset user defaults
        self.isAuthenticating = false
        self.isAuthenticated = false
        self.username = ""
        self.password = ""
        
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "authentication")
        defaults.removeObject(forKey: "storefront")
        defaults.removeObject(forKey: "storePrice")
        
    }
}
