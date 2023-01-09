//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation
import Keychain
import SwiftUI

class AuthAPIModel: ObservableObject {
    
    // Authentication
    @AppStorage("authentication") var authentication = false
    @Published var authenticationAnimation : Bool = false // Handles loading animation
    @Published var authenticationFailure : Bool = false // Handles login error message
    
    // Store
    @Published var storefront : [Skin] = []
    @Published var storePrice : [Offer] = []
    
    // Wallet
    @Published var walletVP : String = ""
    @Published var walletRP : String = ""
    
    // Image Download
    @Published var downloadButtonClicked : Bool = false
    @Published var downloadBarFinish : Bool = false
    
    // Handles reload
    @Published var reloadAnimation : Bool = false
    
    // Multifactor
    @Published var multifactor : Bool = false // Show multifactor popout
    @Published var multifactorAnimation : Bool = false // Handle multifactor loading animation
    @Published var multifactorEmail : String = "" // Displayed email for multifactor popout
    
    // User Information
    @Published var inputUsername: String = "" // Variable used by username box in LoginBoxView
    @Published var inputPassword: String = "" // Used by password box in LoginBoxView
    @Published var inputMultifactor : String = "" // Used by multifactor box in MultifactorView
    
    // Settings
    @AppStorage("rememberPassword") var rememberPassword = false
    
    // Error messages
    @Published var error : Bool = false
    @Published var errorReloading : Bool = false // Specify if the error is of type reloading for custom error message
    @Published var errorMessage : String = ""
    
    // Owned skins
    @Published var ownedSkins : [String] = []
    
    // BundleInformation
    @Published var bundleSkins : [[Skin]] = []
    @Published var bundleImage : [String] = []
    @Published var bundlePrice : [Int] = []
    @Published var bundleCount : Int = 0
    
    // NightMarket
    @Published var nightSkins : [Skin] = []
    @Published var nightDiscount : [Int] = []
    
    let keychain = Keychain()
    let defaults = UserDefaults.standard
    
    
    
    
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
            self.ownedSkins = owned
        }
        
        if let bundlePrice = defaults.array(forKey: "bundlePrice") as? [Int] {
            self.bundlePrice = bundlePrice
        }
        
        if let percentOff = defaults.array(forKey: "percentOff") as? [Int] {
            self.nightDiscount = percentOff
        }
        
        if let objects = defaults.value(forKey: "bundle") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [[Skin]] {
                DispatchQueue.main.async{
                    self.bundleSkins = objectsDecoded
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
        
        // Bundle count
        let count = defaults.integer(forKey: "bundleCount")
            
        DispatchQueue.main.async {
            self.bundleCount = count
        }
        
    }
    
    // MARK: Login
    @MainActor
    func login(skinModel: SkinModel) async {
        
        do{
            
            if self.rememberPassword {
                self.inputUsername = keychain.value(forKey: "username") as? String ?? ""
                self.inputPassword = keychain.value(forKey: "password") as? String ?? ""
            }
            else if keychain.value(forKey: "username") == nil { // Save username to keychain
                let _ = keychain.save(self.inputUsername, forKey: "username")
            }
            
            let _ = try await WebService.getCookies(reload: false)
            
            let tokenList = try await WebService.getToken(username: keychain.value(forKey: "username") as? String ?? self.inputUsername, password: self.inputPassword)
            
            if tokenList.count == 2 {
                // Multifactor login
                self.multifactorEmail = tokenList[1]
                self.authenticationAnimation = false // Disable loading button in case user swipes away multifactor
                self.multifactor = true
            }
            else{
                // Default login (non-multifactor)
                let token = tokenList[0]
                await getPlayerData(helperType: "login", token: token, skinModel: skinModel)
                
                
                DispatchQueue.main.async{
                    // Save authentication state for next launch
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.authentication = true
                    }
                    
                }
                
                self.inputUsername = ""
                self.inputPassword = ""
            }
            print("Finished login")
            
        }catch{
            // Reset user defaults
            self.multifactorEmail = ""
            self.multifactor = false
            
            if self.rememberPassword {
                
                self.error = true
                self.errorReloading = true
                
            }
            else {
                
                self.authenticationAnimation = false
                
                withAnimation(.easeIn(duration: 0.2)) {
                    self.authenticationFailure = true
                }
                
                
                self.defaults.removeObject(forKey: "authentication")
                let _ = keychain.remove(forKey: "username")
            }
            
            self.inputUsername = ""
            self.inputPassword = ""
            
        }
    }
    
    
    // MARK: getPlayerData
    @MainActor
    func getPlayerData(helperType: String, token: String, skinModel : SkinModel) async {
        
        do {
            self.inputPassword = "" // Clear password
            
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
            
            self.ownedSkins = tempOwned
            defaults.set(tempOwned, forKey: "owned")
            
            if storefrontResponse.BonusStore != nil {
                
                defaults.set(true, forKey: "nightMarket")
                
                guard let market = storefrontResponse.BonusStore else {
                    throw APIError.invalidCredentials
                }
                
                var tempMarket : [Skin] = []
                var tempPercent : [Int] = []
                
                for skin in skinModel.data {
                    for item in market.BonusStoreOffers! {
                        let itemUUID = skin.levels!.first!.id.uuidString.lowercased()
                        if itemUUID == item.Offer?.OfferID {
                            
                            let newSkin = skin
                            newSkin.discountedCost = String((item.DiscountCosts?.discountItemCost) ?? 0)

                            tempMarket.append(newSkin)
                            tempPercent.append(item.DiscountPercent ?? 0)
                        }
                    }
                }
                
                withAnimation(.easeIn(duration: 0.15)) {
                    self.nightDiscount = tempPercent
                    self.nightSkins = tempMarket
                }
                
                // Save the storefront
                let storefrontEncoder = JSONEncoder()
                
                if let encoded = try? storefrontEncoder.encode(tempMarket){
                    defaults.set(encoded, forKey: "nightSkins")
                }
                
                let nightReferenceDate = Date() + Double(market.BonusStoreRemainingDurationInSeconds!)
                defaults.set(nightReferenceDate, forKey: "nightTimeLeft")
                defaults.set(tempPercent, forKey: "percentOff")

            }
            else {
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
            withAnimation(.easeIn) {
                self.reloadAnimation = false
            }
        
            self.authenticationAnimation = false
            
        }
        
        catch {
            
            self.errorMessage = "getPlayerData error: \(error.self)" 
            self.error = true
            
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
            
            withAnimation(.easeIn(duration: 0.15)) {
                self.storefront = tempStore
            }
            
            
            // Save the storefront
            let storefrontEncoder = JSONEncoder()
            
            if let encoded = try? storefrontEncoder.encode(tempStore){
                defaults.set(encoded, forKey: "storefront")
            }
            
            // Save user's wallet info
            let wallet = try await WebService.getWallet(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: keychain.value(forKey: "region") as? String ?? "na")
            
            self.walletVP = wallet[0]
            self.walletRP = wallet[1]
            
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

            
            self.authenticationFailure = false
            

            self.inputMultifactor = ""
            
        }catch {
            
            self.errorMessage = "Login Helper error: \(error.self)"
            self.error = true
            
        }
    }
    
    // MARK: BundleReload
    @MainActor
    func bundleLoginHelper(token : String, skinModel : SkinModel, riotEntitlement: String, puuid: String, storefrontResponse : Storefront) async {
        
        do {
            
            guard let bundleList = storefrontResponse.FeaturedBundle else {
                throw BundleListError.invalidList
            }
            
            self.bundleCount = bundleList.bundles.count
            defaults.set(bundleList.bundles.count, forKey: "bundleCount")
            
            var bundleCounter = 0
            var bundleItems : [[Skin]] = []
            var tempImages : [String] = []
            var bundlePrice : [Int] = []
            
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
                var tempBundlePrice = 0
                
                for skin in skinModel.data{
                    for item in items {
                        if skin.levels!.first!.id.description.lowercased() == item.item.itemID {
                            
                            
                            let newSkin = skin
                            newSkin.discountedCost = String((item.basePrice))
                            tempBundleItems.append(newSkin)
                            
                            if !skin.assetPath!.contains("ShooterGame/Content/Equippables/Melee") {
                                tempBundlePrice += item.basePrice
                            }
                            
                            
                        }
                    }
                }
                
                bundleItems.append(tempBundleItems)
                bundlePrice.append(tempBundlePrice)
                
            }
            
            DispatchQueue.main.async {
                
                withAnimation(.easeIn(duration: 0.2)) {
                    self.bundleSkins = bundleItems
                    self.bundleImage = tempImages
                    self.bundlePrice = bundlePrice
                }
                
            }


            // Save the bundle
            let bundleEncoder = JSONEncoder()
            
            if let encoded = try? bundleEncoder.encode(bundleItems){
                defaults.set(encoded, forKey: "bundle")
            }
            
            // Save the bundlePrice
            defaults.set(bundlePrice, forKey: "bundlePrice")
            
            
            
        }
        catch {
            self.errorMessage = "Login Helper error: \(error.self)"
            self.error = true
        }
    }
    
    
    
    // MARK: Multifactor
    @MainActor
    func multifactor(skinModel: SkinModel) async {
        do{
            let token = try await WebService.multifactor(code: self.inputMultifactor)
            
            await getPlayerData(helperType: "login", token: token, skinModel: skinModel)
            self.multifactor = false
            
            
            DispatchQueue.main.async {
                // Save authentication state for next launch
                withAnimation(.easeIn(duration: 0.2)) {
                    self.authentication = true
                }
            }
            
            self.inputUsername = ""
            self.inputPassword = ""
            
        }
        catch{
            
            /*
            self.errorMessage = "Multifactor error, please enter the correct code."
            self.isError = true
            */
            
            // Reset user defaults
            self.multifactorAnimation = false
            self.inputMultifactor = ""
            self.inputPassword = ""
            
            print("Multifactor")
            
        }
    }
    
    // MARK: Reload
    @MainActor
    func reload(skinModel: SkinModel, reloadType : String) async {
        do{
            self.error = true
            self.errorReloading = true
            
            print("Reloading")

            let token = try await WebService.getCookies(reload: true)
            
            // Old way
            //let token = try await WebService.cookieReauth()
            
            if token == "NO TOKEN" {
                
                if self.rememberPassword {
                    print("Attempt relogin")
                    
                    await login(skinModel: skinModel)
                    
                    withAnimation(.easeIn) {
                        self.reloadAnimation = false
                    }

                }
                else {
                    self.error = true
                    self.errorReloading = true
                }
                
            }
            else {
                await getPlayerData(helperType: reloadType, token: token, skinModel: skinModel)
            }

            
        }catch{
            
            if self.rememberPassword {
                
                print("Attempt relogin2")
                
                await login(skinModel: skinModel)
                
                withAnimation(.easeIn) {
                    self.reloadAnimation = false
                }

            }
            else {
                
                
                // Bandaid solution
                let errorMessage = error.localizedDescription
                
                if errorMessage.contains("CookieError") {
                    self.error = true
                    self.errorReloading = true
                }
                else {
                    self.errorMessage = "Reload error: \(error.self)"
                    self.error = true
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
            self.authenticationAnimation = false // Handles loading animation
            self.authenticationFailure = false // Handles login error message
            self.reloadAnimation = false
            self.multifactor = false // Show multifactor popout
            self.multifactorAnimation = false // Handle multifactor loading animation
            self.multifactorEmail = "" // Displayed email for multifactor popout
            self.inputUsername = "" // Variable used by username box in LoginBoxView
            self.inputPassword = "" // Used by password box in LoginBoxView
            self.inputMultifactor = "" // Used by multifactor box in MultifactorView
            
            self.defaults.removeObject(forKey: "timeLeft")
            self.defaults.removeObject(forKey: "vp")
            self.defaults.removeObject(forKey: "rp")
            self.defaults.removeObject(forKey: "storefront")
            self.defaults.removeObject(forKey: "storePrice")
            self.defaults.removeObject(forKey: "rememberPassword")
            
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
                self.defaults.removeObject(forKey: "authentication")
            }
        }
    }
}

