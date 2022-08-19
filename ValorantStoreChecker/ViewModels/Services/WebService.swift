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
    static func getCookies() async throws -> Void {
        guard let url = URL(string: Constants.URL.auth) else{
            throw APIError.invalidURL
        }
        
        
        do{
            
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

                throw APIError.invalidResponseStatus
            }
            
            
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
    }
    
    // MARK: Token
    static func getToken(username: String, password: String) async throws -> [String] {
        guard let url = URL(string: Constants.URL.auth) else{
            throw APIError.invalidURL
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
                throw APIError.invalidResponseStatus
            }
            
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                throw APIError.invalidCredentials
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
                    throw APIError.invalidCredentials
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
            throw APIError.dataTaskError(error.localizedDescription)
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
                throw APIError.invalidResponseStatus
            }
            
            guard let multifactorResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                throw APIError.invalidCredentials
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
                throw APIError.invalidCredentials
            }
            
            
            let uriList = uri.split(separator: "&")
            for item in uriList {
                if item.contains("access_token") {
                    return String(item.split(separator: "=")[1])
                }
            }
            return "NO TOKEN"
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Entitlement
    static func getRiotEntitlement(token: String) async throws -> String {
        guard let url = URL(string: Constants.URL.entitlement) else{
            throw APIError.invalidURL
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
                throw APIError.invalidResponseStatus
            }
            
            guard let entitlementResponse = try? JSONDecoder().decode(Entitlement.self, from: data) else {
                throw APIError.invalidCredentials
            }
            
            guard let riotEntitlement = entitlementResponse.entitlements_token else {
                throw APIError.invalidCredentials
            }
            
            return riotEntitlement
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Player Info
    static func getPlayerInfo(token:String) async throws -> String {
        guard let url = URL(string: Constants.URL.playerInfo) else{
            throw APIError.invalidURL
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
                throw APIError.invalidResponseStatus
            }
            
            guard let puuidResponse = try? JSONDecoder().decode(PUUID.self, from: data) else {
                throw APIError.invalidCredentials
            }
            
            guard let puuid = puuidResponse.sub else {
                throw APIError.invalidCredentials
            }
            
            return puuid
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Storefront
    static func getStorefront(token:String, riotEntitlement: String, puuid: String, region: String) async throws -> Storefront {
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v2/storefront/\(puuid)") else{
            throw APIError.invalidURL
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
                throw APIError.invalidResponseStatus
            }
            
            guard let storefrontResponse = try? JSONDecoder().decode(Storefront.self, from: data) else {
                throw APIError.invalidCredentials
            }
            

            return storefrontResponse
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    
    // MARK: Bundles
    static func getBundle(uuid: String) async throws -> [String] {
        guard let url = URL(string: Constants.URL.bundle + uuid) else{
            throw APIError.invalidURL
        }
        
        do{
            // Create request
            var bundleRequest = URLRequest(url: url)
            bundleRequest.httpMethod = "GET"
            
            let (data,response) = try await WebService.session.data(for: bundleRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw APIError.invalidResponseStatus
            }
            
            guard let bundleResponse = try? JSONDecoder().decode(BundleData.self, from: data) else {
                throw APIError.invalidCredentials
            }
            
            if let url = URL(string: bundleResponse.displayIcon) {
                dataHelper(url: url, key: bundleResponse.uuid)
            }
            
            return [bundleResponse.displayName, bundleResponse.displayIcon]
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Store Prices
    static func getStorePrices(token : String, riotEntitlement: String,region: String) async throws ->  [Offer] {
        
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v1/offers/") else{
            throw APIError.invalidURL
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
            throw APIError.invalidResponseStatus
        }
        
        guard let storePriceResponse = try? JSONDecoder().decode(StorePrice.self, from: data) else {
            throw APIError.invalidCredentials
        }
        
        guard let storePrice = storePriceResponse.offers else {
            throw APIError.invalidCredentials
        }
        
        return storePrice
    }
    
    // MARK: Wallet
    static func getWallet(token : String, riotEntitlement: String, puuid: String, region: String) async throws ->  [String] {
        
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v1/wallet/\(puuid)") else{
            throw APIError.invalidURL
        }
        
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
            throw APIError.invalidResponseStatus
        }
        
        guard let walletResponse = try? JSONDecoder().decode(Wallet.self, from: data) else {
            throw APIError.invalidCredentials
        }
        
        guard let vp = walletResponse.balances?.vp, let rp = walletResponse.balances?.rp else {
            throw APIError.invalidCredentials
        }
        
        return [String(vp), String(rp)]
        
    }
    
    // MARK: Reauthentication / Reloading
    static func cookieReauth () async throws -> String {
        guard let url = URL(string: Constants.URL.cookieReauth) else{
            throw APIError.invalidURL
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
            
            
            guard let urlString = response.url?.absoluteString else{
                throw APIError.noData
            }
            
            // Split uri and obtain access token
            let split = urlString.split(separator: "=")
            let token = String(split[1].split(separator: "&")[0])
            
            print(token)
            print ("Reload Sucessful")
            return token
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    // MARK: Owned Skins
    static func getOwned(token : String, riotEntitlement: String, puuid: String, region: String) async throws ->  [SkinEntitlement] {
        
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v1/entitlements/\(puuid)/e7c63390-eda7-46e0-bb7a-a6abdacd2433") else{
            throw APIError.invalidURL
        }
        
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
            throw APIError.invalidResponseStatus
        }
        
        guard let ownedResponse = try? JSONDecoder().decode(Owned.self, from: data) else {
            throw APIError.invalidCredentials
        }
        
        guard let owned = ownedResponse.entitlements else {
            throw APIError.invalidCredentials
        }
        
        return owned
        
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


