//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation
import Keychain

class AuthAPIModel: ObservableObject {
    
    // Store
    @Published var storefront : [Skin] = []
    @Published var storePrice : [Offer] = []
    @Published var vp : String = ""
    @Published var rp : String = ""
    
    // Authentication
    @Published var isAuthenticated: Bool = false // Keeps user logged in
    @Published var isAuthenticating : Bool = false // Handles loading animation
    @Published var failedLogin : Bool = false // Handles login error message
    
    // Handles reload animation
    @Published var reloading : Bool = false
    
    // Multifactor
    @Published var showMultifactor : Bool = false // Show multifactor popout
    @Published var enteredMultifactor : Bool = false // Handle multifactor loading animation
    @Published var email : String = "" // Displayed email for multifactor popout
    
    // User Information
    @Published var username: String = "" // Variable used by username box in LoginBoxView
    @Published var password: String = "" // Used by password box in LoginBoxView
    @Published var multifactor : String = "" // Used by multifactor box in MultifactorView
    @Published var regionCheck : Bool = false
    
    // User saved information
    @Published var keychain = Keychain() // For sensitive information
    @Published var defaults = UserDefaults.standard // For general information
    
    
    init() {
        
        // TODO: Implement CoreData, but for now lmao this works
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
    
    // MARK: Login
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
                // Multifactor login
                self.email = tokenList[1]
                self.showMultifactor = true
                self.isAuthenticating = false
            }
            else{
                // Regular login
                let token = tokenList[0]
                await loginHelper(token: token)
                
                self.isAuthenticated = true
                defaults.set(self.isAuthenticated, forKey: "authentication") // Save authentication state for next launch
            }
            
            
            
        }catch{
            // Reset user defaults
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
    
    // MARK: LoginHelper
    @MainActor
    func loginHelper(token : String) async {
        do {
            self.password = String(repeating: "a", count: (self.password.count)) // Clear password from memory and put in a placeholder
            let riotEntitlement = try await WebService.getRiotEntitlement(token: token)
            
            let puuid = try await WebService.getPlayerInfo(token: token)
            let storefront = try await WebService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: defaults.string(forKey: "region") ?? "na")
            let wallet = try await WebService.getWallet(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: defaults.string(forKey: "region") ?? "na")
            
            
            
            // Save user's wallet info
            self.vp = wallet[0]
            self.rp = wallet[1]
            
            self.defaults.set(wallet[0], forKey: "vp")
            self.defaults.set(wallet[1], forKey: "rp")
            
            // Match user's store with database
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
            
            
            self.username = ""
            self.password = ""
            self.multifactor = ""
            
        }catch {
            // Reset user defaults
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
    
    // MARK: Multifactor
    @MainActor
    func multifactor() async {
        if enteredMultifactor{
            do{
                let token = try await WebService.multifactor(code: self.multifactor)
                
                self.isAuthenticated = true
                defaults.set(self.isAuthenticated, forKey: "authentication") // Save authentication state for next launch
                
                await loginHelper(token: token)
                self.showMultifactor = false
                self.enteredMultifactor = false
            }
            catch{
                // Reset user defaults
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
    
    // MARK: Reload
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
    
    // MARK: Log Out
    @MainActor
    func logOut() {
        
        // Create a new session
        WebService.session = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = 30 // seconds
            configuration.timeoutIntervalForResource = 30 // seconds
            return URLSession(configuration: configuration)
        }()
        

        
        self.isAuthenticated = false // Keeps user logged in
        self.isAuthenticating = false // Handles loading animation
        self.failedLogin = false // Handles login error message
        self.reloading = false
        self.showMultifactor = false // Show multifactor popout
        self.enteredMultifactor = false // Handle multifactor loading animation
        self.email = "" // Displayed email for multifactor popout
        self.username = "" // Variable used by username box in LoginBoxView
        self.password = "" // Used by password box in LoginBoxView
        self.multifactor = "" // Used by multifactor box in MultifactorView
        self.regionCheck = false
        
        defaults.removeObject(forKey: "authentication")
        defaults.removeObject(forKey: "region")
        defaults.removeObject(forKey: "timeLeft")
        defaults.removeObject(forKey: "vp")
        defaults.removeObject(forKey: "rp")
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "storefront")
        defaults.removeObject(forKey: "storePrice")
        
        let _ = keychain.remove(forKey: "ssid")
        let _ = keychain.remove(forKey: "tdid")
    }
}
