//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Thanks to https://github.com/juliand665 for invaluable insight
//  ⚠️Documentation: https://github.com/techchrism/valorant-api-docs/tree/trunk/docs⚠️


import Foundation
import Keychain

struct WebService {
    // Common URLSession
    static var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30 // seconds
        return URLSession(configuration: configuration)
    }()
    
    // MARK: Cookies
    static func getCookies(reload: Bool) async throws -> String {
        
        guard let url = URL(string: Constants.URL.auth) else{
            throw CookieError.invalidURL
        }
        
        do{
            
            if reload {
                
                let keychain = Keychain()
                
                try await setCookie(named: "tdid", to: keychain.value(forKey: "tdid") as? String ?? "")
                try await setCookie(named: "ssid", to: keychain.value(forKey: "ssid") as? String ?? "")
                
                let recookieBody = ReAuthCookies()
                
                // Create request
                var cookieRequest = URLRequest(url: url)
                cookieRequest.httpMethod = "POST"
                cookieRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                cookieRequest.httpBody = try! JSONEncoder().encode(recookieBody)
                
                // Get cookies
                let (data , response) = try await WebService.session.data(for: cookieRequest)
                
                // Verify server request
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else{
                    throw CookieReloadError.invalidResponseStatus
                }
                
                guard let cookieResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                    throw CookieReloadError.badDecode
                }
                
                guard let uri = cookieResponse.response?.parameters?.uri else {
                    throw CookieReloadError.badURI
                }
                
                // Obtain uri and parse for the token
                let uriList = uri.split(separator: "&")
                
                for item in uriList {
                    if item.contains("access_token") {
                        let token = item.split(separator: "=")[1]
                        if token.count != 0 {
                            return String(item.split(separator: "=")[1])
                        }
                        
                    }
                }
                
                return "NO TOKEN"
                
            }
            else {
                
                let cookieBody = AuthCookies()
                
                // Create request
                var cookieRequest = URLRequest(url: url)
                cookieRequest.httpMethod = "POST"
                cookieRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                cookieRequest.httpBody = try! JSONEncoder().encode(cookieBody)
                
                // Get cookies
                let (_ , response) = try await WebService.session.data(for: cookieRequest)
                
                // Verify server request
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else{
                    throw CookieError.invalidResponseStatus
                }
                
                return "OK"
            }
            
            
            
            
            
        }catch{
            throw CookieError.dataTaskError(error.localizedDescription)
        }
        
    }
    
    // MARK: Token
    static func getToken(username: String, password: String) async throws -> [String] {
        guard let url = URL(string: Constants.URL.auth) else{
            throw TokenError.invalidURL
        }
        
        do{
            let requestBody = AuthRequestBody(username: username, password: password)
            
            // Create authentication request
            var authRequest = URLRequest(url: url)
            authRequest.httpMethod = "PUT"
            authRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            authRequest.httpBody = try! JSONEncoder().encode(requestBody)
            
            // Get token
            let (data , response) = try await WebService.session.data(for: authRequest)
            
            // Verify server request
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw TokenError.invalidResponseStatus
            }
            
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                throw TokenError.invalidCredentials
            }
            
            // Determine if multifactor is required
            if authResponse.type == "multifactor" {
                
                return ["multifactor" , (authResponse.multifactor?.email)!]
                
            }
            else{
                
                let keychain = Keychain()
                
                // Obtain SSID and TDID for reloading store
                let field = httpResponse.value(forHTTPHeaderField: "Set-Cookie")
                let fieldString = String(field!)
                let fieldStringList = fieldString.split(separator: ";")
                
                var cleanedArray: [String] = []
                
                for item in fieldStringList {
                    let newList = item.split(separator: ",")
                    for thing in newList {
                        let newString = thing.trimmingCharacters(in: .whitespaces)
                        cleanedArray.append(newString)
                    }
                }
                
                // Store securely in keychain
                for item in cleanedArray {
                    if item.contains("tdid") {
                        let _ = keychain.save(item.split(separator: "=")[1], forKey: "tdid")
                    }
                    else if item.contains("ssid") {
                        let _ = keychain.save(item.split(separator: "=")[1], forKey: "ssid")
                    }
                }
                
                
                guard let uri = authResponse.response?.parameters?.uri else {
                    throw TokenError.badURI
                }
                
                // Obtain uri and parse for the token
                let uriList = uri.split(separator: "&")
                for item in uriList {
                    if item.contains("access_token") {
                        return [String(item.split(separator: "=")[1])]
                    }
                }
                
                return ["NO TOKEN"]
            }
            
        }catch{
            throw TokenError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Multifactor
    static func multifactor (code: String) async throws -> String {
        guard let url = URL(string: Constants.URL.auth) else{
            throw APIError.invalidURL
        }
        
        do{
            let multifactorBody = MultifactorBody(code: code)
            
            // Create authentication request
            var multifactorRequest = URLRequest(url: url)
            multifactorRequest.httpMethod = "PUT"
            multifactorRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            multifactorRequest.httpBody = try! JSONEncoder().encode(multifactorBody)
            
            // Get token
            let (data , response) = try await WebService.session.data(for: multifactorRequest)
            
            // Verify server request
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw MultifactorError.invalidResponseStatus
            }
            
            guard let multifactorResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                throw MultifactorError.invalidCredentials
            }
            
            
            let keychain = Keychain()
            
            // Parse for and store SSID and TDID for reloading
            let field = httpResponse.value(forHTTPHeaderField: "Set-Cookie")
            let fieldString = String(field!)
            let fieldStringList = fieldString.split(separator: ";")
            
            var cleanedArray: [String] = []
            
            // Store securely in keychain
            for item in fieldStringList {
                let newList = item.split(separator: ",")
                for thing in newList {
                    let newString = thing.trimmingCharacters(in: .whitespaces)
                    cleanedArray.append(newString)
                }
            }
            
            for item in cleanedArray {
                if item.contains("tdid") {
                    let _ = keychain.save(item.split(separator: "=")[1], forKey: "tdid")
                }
                else if item.contains("ssid") {
                    let _ = keychain.save(item.split(separator: "=")[1], forKey: "ssid")
                }
            }
            
            guard let uri = multifactorResponse.response?.parameters?.uri else {
                throw MultifactorError.badURI
            }
            
            
            let uriList = uri.split(separator: "&")
            for item in uriList {
                if item.contains("access_token") {
                    return String(item.split(separator: "=")[1])
                }
            }
            return "NO TOKEN"
            
        }catch{
            throw MultifactorError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Entitlement
    static func getRiotEntitlement(token: String) async throws -> String {
        guard let url = URL(string: Constants.URL.entitlement) else{
            throw EntitlementError.invalidURL
        }
        
        do{
            // Create request
            var entitlementRequest = URLRequest(url: url)
            entitlementRequest.httpMethod = "POST"
            entitlementRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            entitlementRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data,response) = try await WebService.session.data(for: entitlementRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw EntitlementError.invalidResponseStatus
            }
            
            guard let entitlementResponse = try? JSONDecoder().decode(Entitlement.self, from: data) else {
                throw EntitlementError.invalidCredentials
            }
            
            guard let riotEntitlement = entitlementResponse.entitlements_token else {
                throw EntitlementError.badDecode
            }
            
            return riotEntitlement
            
        }catch{
            throw EntitlementError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Player Info
    static func getPlayerInfo(token:String) async throws -> String {
        guard let url = URL(string: Constants.URL.playerInfo) else{
            throw PlayerError.invalidURL
        }
        
        do{
            // Create puuid request
            var puuidRequest = URLRequest(url: url)
            puuidRequest.httpMethod = "GET"
            puuidRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data,response) = try await WebService.session.data(for: puuidRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw PlayerError.invalidResponseStatus
            }
            
            guard let puuidResponse = try? JSONDecoder().decode(PUUID.self, from: data) else {
                throw PlayerError.badDecode
            }
            
            guard let puuid = puuidResponse.sub else {
                throw PlayerError.noData
            }
            
            return puuid
            
        }catch{
            throw PlayerError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Storefront
    static func getStorefront(token:String, riotEntitlement: String, puuid: String, region: String) async throws -> Storefront {
        

        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v2/storefront/\(puuid)") else{
            throw StorefrontError.invalidURL
        }
        
        do{
            // Create request
            var storefrontRequest = URLRequest(url: url)
            storefrontRequest.httpMethod = "GET"
            storefrontRequest.addValue(riotEntitlement, forHTTPHeaderField: "X-Riot-Entitlements-JWT")
            storefrontRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data,response) = try await WebService.session.data(for: storefrontRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw StorefrontError.invalidResponseStatus
            }
            
            guard let storefrontResponse = try? JSONDecoder().decode(Storefront.self, from: data) else {
                throw StorefrontError.badDecode
            }
            
            return storefrontResponse
            
        }catch{
            throw StorefrontError.dataTaskError(error.localizedDescription)
        }
         
    }
    
    
    // MARK: Bundles
    static func getBundle(uuid: String, currentBundle: String) async throws -> [String] {
        
        guard let url1 = URL(string: Constants.URL.bundle + uuid) else{
            throw BundleError.invalidURL
        }
        
        /*
        guard let url2 = URL(string: "https://api.valorantstore.net/store-featured") else {
            throw BundleError.invalidURL
        }
        */
        
        do{
            // Create request
            var bundleRequest1 = URLRequest(url: url1)
            bundleRequest1.httpMethod = "GET"
            
            let (data1,response1) = try await WebService.session.data(for: bundleRequest1)
            
            guard
                let httpResponse = response1 as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw BundleError.invalidResponseStatus
            }
            
            guard let bundleResponse1 = try? JSONDecoder().decode(BundleResponse.self, from: data1) else {
                throw BundleError.badDecode
            }
            
            if let url = URL(string: bundleResponse1.data.displayIcon) {
                dataHelper(url: url, key: "bundleDisplayIcon" + currentBundle)
            }
            
            /*
            var bundleRequest2 = URLRequest(url: url2)
            bundleRequest2.httpMethod = "GET"
            
            let (data2,response2) = try await WebService.session.data(for: bundleRequest2)
            
            guard
                let httpResponse = response2 as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw BundleError.invalidResponseStatus
            }
            
            guard let bundleResponse2 = try? JSONDecoder().decode(ValStoreBundle.self, from: data2) else {
                throw BundleError.badDecode
            }
            
            if !bundleResponse2.data.isEmpty {
                return [bundleResponse1.data.displayName, bundleResponse1.data.displayIcon, String(bundleResponse2.data.first!.price)]
            }
            */
            return [bundleResponse1.data.displayName, bundleResponse1.data.displayIcon]
            
            
        }catch{
            throw BundleError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Store Prices
    static func getStorePrices(token : String, riotEntitlement: String,region: String) async throws -> [Offer] {
        
        do {
            guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v1/offers/") else{
                throw PriceError.invalidURL
            }
            
            // Create request
            var storePriceRequest = URLRequest(url: url)
            storePriceRequest.httpMethod = "GET"
            storePriceRequest.addValue(riotEntitlement, forHTTPHeaderField: "X-Riot-Entitlements-JWT")
            storePriceRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data , response) = try await WebService.session.data(for: storePriceRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw PriceError.invalidResponseStatus
            }
            
            guard let storePriceResponse = try? JSONDecoder().decode(StorePrice.self, from: data) else {
                throw PriceError.badDecode
            }
            
            guard let storePrice = storePriceResponse.offers else {
                throw PriceError.noData
            }
            
            return storePrice
        }
        catch {
            throw PriceError.dataTaskError(error.localizedDescription)
        }
        
    }
    
    // MARK: Wallet
    static func getWallet(token : String, riotEntitlement: String, puuid: String, region: String) async throws ->  [String] {
        
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v1/wallet/\(puuid)") else{
            throw WalletError.invalidURL
        }
        
        do {
            // Create request
            var walletRequest = URLRequest(url: url)
            walletRequest.httpMethod = "GET"
            walletRequest.addValue(riotEntitlement, forHTTPHeaderField: "X-Riot-Entitlements-JWT")
            walletRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data , response) = try await WebService.session.data(for: walletRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw WalletError.invalidResponseStatus
            }
            
            guard let walletResponse = try? JSONDecoder().decode(Wallet.self, from: data) else {
                throw WalletError.badDecode
            }
            
            guard let vp = walletResponse.balances?.vp, let rp = walletResponse.balances?.rp else {
                throw WalletError.noData
            }
            
            return [String(vp), String(rp)]
        }
        catch {
            throw WalletError.dataTaskError(error.localizedDescription)
        }
        
    }
    
    
    // MARK: Reauthentication / Reloading
    static func cookieReauth () async throws -> String {
        
        
        
        guard let url = URL(string: Constants.URL.cookieReauth) else{
            throw CookieAuthError.invalidURL
        }
        
        do{
            
            let keychain = Keychain()
            
            try await setCookie(named: "tdid", to: keychain.value(forKey: "tdid") as? String ?? "")
            try await setCookie(named: "ssid", to: keychain.value(forKey: "ssid") as? String ?? "")
            
            // Create request
            var cookieReauthRequest = URLRequest(url: url)
            cookieReauthRequest.httpMethod = "GET"
            
            // Get token
            let (_ , response) = try await WebService.session.data(for: cookieReauthRequest)
            
            /*
            guard
                let httpResponse = response as? HTTPURLResponse
            else{
                print("CookieAuthError.invalidResponseStatus")
                throw PriceError.invalidResponseStatus
            }
            */

            
            guard let urlString = response.url?.absoluteString else{
                throw CookieAuthError.noData
            }
            
            // Split uri and obtain access token
            let uriList = urlString.split(separator: "&")
            for item in uriList {
                if item.contains("access_token") {
                    return String(item.split(separator: "=")[1])
                }
            }

            return "NO TOKEN"
            
        }catch{
            throw CookieAuthError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Owned Skins
    static func getOwned(token : String, riotEntitlement: String, puuid: String, region: String) async throws ->  [SkinEntitlement] {
        
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v1/entitlements/\(puuid)/e7c63390-eda7-46e0-bb7a-a6abdacd2433") else{
            throw OwnedError.invalidURL
        }
        
        do {
            // Create request
            var ownedRequest = URLRequest(url: url)
            ownedRequest.httpMethod = "GET"
            ownedRequest.addValue(riotEntitlement, forHTTPHeaderField: "X-Riot-Entitlements-JWT")
            ownedRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data , response) = try await WebService.session.data(for: ownedRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw OwnedError.invalidResponseStatus
            }
            
            guard let ownedResponse = try? JSONDecoder().decode(Owned.self, from: data) else {
                throw OwnedError.badDecode
            }
            
            guard let owned = ownedResponse.entitlements else {
                throw OwnedError.noData
            }
            
            return owned
            
        }
        catch {
            throw OwnedError.dataTaskError(error.localizedDescription)
        }
    }
    
    
    
    
    
    // MARK: Helper function
    // Configure websession for reloading / reauthentication
    static func setCookie(named name: String, to value: String) async throws -> Void{
        WebService.session.configuration.httpCookieStorage!.setCookie(.init(properties: [
            .name: name,
            .value: value,
            .path: "/",
            .domain: "auth.riotgames.com",
        ])!)
    }
    
    // MARK: Download stuff
    static func dataHelper (url : URL, key : String) {
        // Get a session
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                return
            }
            
            if error == nil {
                
                DispatchQueue.main.async {
                    // Set the image data
                    if data != nil {
                        let encoded = try! PropertyListEncoder().encode(data)
                        UserDefaults.standard.set(encoded, forKey: key)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    
}


