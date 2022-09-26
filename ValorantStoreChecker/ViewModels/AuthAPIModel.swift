//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation
import Keychain
import BackgroundTasks
import SwiftUI

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
    
    // Handles reload
    @Published var reloading : Bool = false
    @Published var autoReload : Bool = false
    
    // Multifactor
    @Published var showMultifactor : Bool = false // Show multifactor popout
    @Published var enteredMultifactor : Bool = false // Handle multifactor loading animation
    @Published var email : String = "" // Displayed email for multifactor popout
    
    // User Information
    @Published var username: String = "" // Variable used by username box in LoginBoxView
    @Published var password: String = "" // Used by password box in LoginBoxView
    @Published var multifactor : String = "" // Used by multifactor box in MultifactorView
    @Published var regionCheck : Bool = false // COnfirm user has selected region
    @Published var rememberPassword : Bool = false
    
    // User saved information
    @Published var keychain = Keychain() // For sensitive information
    @Published var defaults = UserDefaults.standard // For general information
    
    // Error messages
    @Published var isError : Bool = false
    @Published var isReloadingError : Bool = false
    @Published var errorMessage : String = ""
    
    // Owned skins
    @Published var owned : [String] = []
    
    // BundleInformation
    @Published var bundleImage : [String] = []
    @Published var bundle : [[Skin]] = []
    
    // NightMarket
    @Published var nightMarket : Bool = false
    @Published var nightSkins : [Skin] = []
    
    init() {
        
        // TODO: Implement CoreData, but for now lmao this works
        // Use saved storefront
        if let objects = defaults.value(forKey: "storefront") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Skin] {
                DispatchQueue.main.async{
                    self.storefront = objectsDecoded
                }
            }
        }
        
        // Use saved storeprice
        if let objects = defaults.value(forKey: "storePrice") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Offer] {
                DispatchQueue.main.async{
                    self.storePrice = objectsDecoded
                }
            }
        }
        
        if let owned = defaults.array(forKey: "owned") as? [String] {
            self.owned = owned
        }
        
        if let objects = defaults.value(forKey: "bundle") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [[Skin]] {
                DispatchQueue.main.async{
                    self.bundle = objectsDecoded
                }
            }
        }
        
        // Use saved nightmarket
        if let objects = defaults.value(forKey: "nightSkins") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Skin] {
                DispatchQueue.main.async{
                    self.nightSkins = objectsDecoded
                }
            }
        }
        
        
        
    }
    
    // MARK: Login
    @MainActor
    func login(skinModel: SkinModel) async{
        
        do{
            
            if self.rememberPassword || defaults.bool(forKey: "rememberPassword"){
                self.username = keychain.value(forKey: "username") as? String ?? ""
                self.password = keychain.value(forKey: "password") as? String ?? ""
                
            }
            
            else if keychain.value(forKey: "username") == nil { // Save username to keychain
                let _ = keychain.save(self.username, forKey: "username")
            }
            
            let _ = try await WebService.getCookies(reload: false)
            
            let tokenList = try await WebService.getToken(username: keychain.value(forKey: "username") as? String ?? "", password: self.password)
            
            if tokenList.count == 2 {
                // Multifactor login
                self.email = tokenList[1]
                self.showMultifactor = true
                self.isAuthenticating = false // Disable loading button in case user swipes away multifactor
            }
            else{
                // Default login (non-multifactor)
                let token = tokenList[0]
                await getPlayerData(helperType: "login", token: token, skinModel: skinModel)
                
                
                DispatchQueue.main.async{
                    // Save authentication state for next launch
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.isAuthenticated = true
                        self.defaults.set(true, forKey: "authentication")
                    }
                }
                
                
                
            }
            print("Finished login")
            
        }catch{
            // Reset user defaults
            self.email = ""
            self.showMultifactor = false
            
            if self.rememberPassword || defaults.bool(forKey: "rememberPassword"){
                
                self.isError = true
                self.isReloadingError = true
                
            }
            else {
                self.isAuthenticating = false
                self.failedLogin = true
                defaults.removeObject(forKey: "authentication")
                let _ = keychain.remove(forKey: "username")
            }
            
            self.username = ""
            self.password = ""
            
            
        }
    }
    
    
    // MARK: getPlayerData
    @MainActor
    func getPlayerData(helperType: String, token: String, skinModel : SkinModel) async {
        do {
            self.password = "" // Clear password
            
            let riotEntitlement = try await WebService.getRiotEntitlement(token: token)
            let puuid = try await WebService.getPlayerInfo(token: token)
            
            // Match user's store with database
            let storefrontResponse = try await WebService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: keychain.value(forKey: "region") as? String ?? "na")
            
            // Save list of owned skins
            let owned = try await WebService.getOwned(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: keychain.value(forKey: "region") as? String ?? "na")
            
            var tempOwned : [String] = []
            
            
            for skin in skinModel.data {
                for item in owned {
                    let itemUUID = skin.levels!.first!.id.uuidString.lowercased()
                    if itemUUID == item.itemID {
                        if !tempOwned.contains(skin.displayName) {
                            tempOwned.append(skin.displayName)
                        }
                    }
                }
            }
            
            self.owned = tempOwned
            defaults.set(tempOwned, forKey: "owned")
            
            if storefrontResponse.BonusStore != nil {
                
                self.nightMarket = true
                defaults.set(true, forKey: "nightMarket")
                
                guard let market = storefrontResponse.BonusStore else {
                    throw APIError.invalidCredentials
                }
                
                var tempMarket : [Skin] = []
                
                for skin in skinModel.data {
                    for item in market.BonusStoreOffers! {
                        let itemUUID = skin.levels!.first!.id.uuidString.lowercased()
                        if itemUUID == item.Offer?.OfferID {
                            
                            
                            
                            let newSkin = skin
                            newSkin.discountedCost = String((item.DiscountCosts?.discountItemCost)!)

                            tempMarket.append(newSkin)
                        }
                    }
                }
                
                self.nightSkins = tempMarket
                
                // Save the storefront
                let storefrontEncoder = JSONEncoder()
                
                if let encoded = try? storefrontEncoder.encode(tempMarket){
                    defaults.set(encoded, forKey: "nightSkins")
                }
                
                let nightReferenceDate = Date() + Double(market.BonusStoreRemainingDurationInSeconds!)
                defaults.set(nightReferenceDate, forKey: "nightTimeLeft")

            }
            else {
                self.nightMarket = false
                defaults.set(false, forKey: "nightMarket")
                
            }
            
            if helperType == "storeReload" {
                
                await reloadLoginHelper(token: token, skinModel: skinModel, riotEntitlement: riotEntitlement, puuid: puuid, storefrontResponse: storefrontResponse)
                
            }
            else if helperType == "bundleReload" {
                
                await bundleLoginHelper(token: token, skinModel: skinModel, riotEntitlement: riotEntitlement, puuid: puuid, storefrontResponse: storefrontResponse)
                
            }
            else if helperType == "nightMarketReload" {
                
                // Placeholder
            }
            else if helperType == "login" {
                await reloadLoginHelper(token: token, skinModel: skinModel, riotEntitlement: riotEntitlement, puuid: puuid, storefrontResponse: storefrontResponse)
                await bundleLoginHelper(token: token, skinModel: skinModel, riotEntitlement: riotEntitlement, puuid: puuid, storefrontResponse: storefrontResponse)
            }
            
            // finished loading
            self.reloading = false
            self.isAuthenticating = false
            
        }
        catch {
            self.errorMessage = "getPlayerData error: \(error.localizedDescription)"
            self.isError = true
        }
    }
    
    
    
    // MARK: LoginHelper
    @MainActor
    func reloadLoginHelper(token : String, skinModel : SkinModel, riotEntitlement: String, puuid: String, storefrontResponse : Storefront) async {
        do {
            
            guard let storefront = storefrontResponse.SkinsPanelLayout else {
                throw APIError.invalidCredentials
            }
            
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
            
            // Save the storefront
            let storefrontEncoder = JSONEncoder()
            
            if let encoded = try? storefrontEncoder.encode(tempStore){
                defaults.set(encoded, forKey: "storefront")
            }
            
            // Save user's wallet info
            let wallet = try await WebService.getWallet(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: keychain.value(forKey: "region") as? String ?? "na")
            
            self.vp = wallet[0]
            self.rp = wallet[1]
            
            self.defaults.set(wallet[0], forKey: "vp")
            self.defaults.set(wallet[1], forKey: "rp")
            
            // Get store price
            let storePrice = try await WebService.getStorePrices(token: token, riotEntitlement: riotEntitlement, region: keychain.value(forKey: "region") as? String ?? "na")
            
            self.storePrice = storePrice
            
            // Save store prices
            let priceEncoder = JSONEncoder()
            if let encoded = try? priceEncoder.encode(storePrice){
                defaults.set(encoded, forKey: "storePrice")
            }
            
            // Set the time left in shop
            let referenceDate = Date() + Double(storefront.SingleItemOffersRemainingDurationInSeconds ?? 0)
            defaults.set(referenceDate, forKey: "timeLeft")

            
            self.failedLogin = false
            
            self.username = ""
            self.password = ""
            self.multifactor = ""
            
        }catch {
            
            self.errorMessage = "Login Helper error: \(error.localizedDescription)"
            self.isError = true
            
        }
    }
    
    // MARK: BundleReload
    @MainActor
    func bundleLoginHelper(token : String, skinModel : SkinModel, riotEntitlement: String, puuid: String, storefrontResponse : Storefront) async {
        
        do {
            
            guard let bundleList = storefrontResponse.FeaturedBundle else {
                throw BundleListError.invalidList
            }
            
            
            defaults.set(bundleList.bundles.count, forKey: "bundleCount")
            
            var bundleCounter = 0
            var bundleItems : [[Skin]] = []
            var tempImages : [String] = []
            
            for item in bundleList.bundles {
                bundleCounter += 1
                let currentBundle = String(bundleCounter)
                
                let bundleUUID = item.dataAssetID
                let bundle = try await WebService.getBundle(uuid: bundleUUID, currentBundle: currentBundle)
                
                let bundleDisplayName = bundle[0]
                let bundleDisplayIcon = bundle[1]
                
                tempImages.append(bundleDisplayIcon)
                
                defaults.set(bundleDisplayName, forKey: "bundleDisplayName" + currentBundle)
                // Set time left for bundle
                let bundleReferenceDate = Date() + Double(item.durationRemainingInSeconds)
                defaults.set(bundleReferenceDate, forKey: "bundleTimeLeft" + currentBundle)
                
                
                // Save the bundle skins
                let items = item.items
                
                var tempBundleItems : [Skin] = []
                
                for skin in skinModel.data{
                    for item in items {
                        if skin.levels!.first!.id.description.lowercased() == item.item.itemID {
                            tempBundleItems.append(skin)
                        }
                    }
                }
                
                bundleItems.append(tempBundleItems)
                
            }

            self.bundle = bundleItems
            self.bundleImage = tempImages
            
            // Save the bundle
            let bundleEncoder = JSONEncoder()
            
            if let encoded = try? bundleEncoder.encode(bundleItems){
                defaults.set(encoded, forKey: "bundle")
            }
        }
        catch {
            self.errorMessage = "Login Helper error: \(error.localizedDescription)"
            self.isError = true
        }
    }
    
    
    
    // MARK: Multifactor
    @MainActor
    func multifactor(skinModel: SkinModel) async {
        if enteredMultifactor{
            do{
                let token = try await WebService.multifactor(code: self.multifactor)
                
                await getPlayerData(helperType: "login", token: token, skinModel: skinModel)
                self.showMultifactor = false
                self.enteredMultifactor = false
                
                // Save authentication state for next launch
                withAnimation(.easeIn(duration: 0.2)) {
                    self.isAuthenticated = true
                    defaults.set(true, forKey: "authentication")
                }
                
            }
            catch{
                
                /*
                self.errorMessage = "Multifactor error, please enter the correct code."
                self.isError = true
                */
                
                // Reset user defaults
                self.enteredMultifactor = false
                self.multifactor = ""
                self.password = ""
                
                
                print("Multifactor")
                
            }
            
        }
    }
    
    // MARK: Reload
    @MainActor
    func reload(skinModel: SkinModel, reloadType : String) async {
        do{
            
            print("Reloading")
            
            let token = try await WebService.getCookies(reload: true)
            
            // Old way
            //let token = try await WebService.cookieReauth()
            
            if token == "NO TOKEN" {
                
                if (self.rememberPassword || defaults.bool(forKey: "rememberPassword")) {
                    print("Attempt relogin")
                    
                    await login(skinModel: skinModel)
                    self.reloading = false
                    
                }
                else {
                    self.isError = true
                    self.isReloadingError = true
                }
                
            }
            else {
                await getPlayerData(helperType: reloadType, token: token, skinModel: skinModel)
            }

            
        }catch{
            
            if (self.rememberPassword || defaults.bool(forKey: "rememberPassword")) {
                print("Attempt relogin2")
                
                await login(skinModel: skinModel)
                self.reloading = false
            }
            else {
                
                //self.isReloadingError = true
                
                let errorMessage = error.localizedDescription.split(separator: "(")[1].split(separator: " ")[0]
                
                
                if errorMessage == "ValorantStoreChecker.CookieError" {
                    
                    self.isError = true
                    self.isReloadingError = true
                    
                }
                else {
                    self.errorMessage = "Reload error: \(error.localizedDescription)"
                    self.isError = true
                }
                
            }
            
            print("Reloading error")
            
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
        

        DispatchQueue.main.async{
            // Reset Defaults
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
            self.rememberPassword = false
            
            self.defaults.removeObject(forKey: "timeLeft")
            self.defaults.removeObject(forKey: "vp")
            self.defaults.removeObject(forKey: "rp")
            self.defaults.removeObject(forKey: "storefront")
            self.defaults.removeObject(forKey: "storePrice")
            self.defaults.removeObject(forKey: "rememberPassword")
            self.defaults.removeObject(forKey: "autoReload")
            self.defaults.removeObject(forKey: "notification")
            
            self.defaults.removeObject(forKey: "owned")
            self.defaults.removeObject(forKey: "bundle")
            self.defaults.removeObject(forKey: "nightSkins")
            self.defaults.removeObject(forKey: "nightTimeLeft")
            self.defaults.removeObject(forKey: "bundleTimeLeft")
            self.defaults.removeObject(forKey: "timeLeft")
            
            let _ = self.keychain.remove(forKey: "ssid")
            let _ = self.keychain.remove(forKey: "tdid")
            let _ = self.keychain.remove(forKey: "region")
            let _ = self.keychain.remove(forKey: "username")
            let _ = self.keychain.remove(forKey: "password")
            
            // Unauthenticate user
            withAnimation(.easeOut(duration: 0.2)) {
                self.isAuthenticated = false // Keeps user logged in
                self.defaults.removeObject(forKey: "authentication")
            }
        }
        
        

    }
    
    
}

