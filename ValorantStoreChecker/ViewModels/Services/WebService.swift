//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made with the help of https://github.com/juliand665
//  Used https://github.com/techchrism/valorant-api-docs/tree/trunk/docs for docs


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
    
    static func getToken(username: String, password: String) async throws -> String {
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
            
            // The really stupid way of obtaining ssid and tdid for cookieReauth, but it works so I'm not touching it
            // TODO: Make this in a way where a change on rito's end wont break it
            let keychain = Keychain()
            
            let field = httpResponse.value(forHTTPHeaderField: "Set-Cookie")
            let fieldString = String(field!)
            let fieldStringList = fieldString.split(separator: "=")
            let tdid = fieldStringList[1].split(separator: ";")[0]
            let ssid = fieldStringList[12].split(separator: ";")[0]
            
            // Securing with keychain
            let _ = keychain.save(tdid, forKey: "tdid")
            let _ = keychain.save(ssid, forKey: "ssid")
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                throw APIError.invalidCredentials
            }
            
            guard let uri = authResponse.response?.parameters?.uri else {
                throw APIError.invalidCredentials
            }
            
            
            // TODO: Make this in a way where a change on rito's end wont break it
            let split = uri.split(separator: "=")
            let token = String(split[1].split(separator: "&")[0])

            return token
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
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

    static func getStorefront(token:String, riotEntitlement: String, puuid: String, region: String) async throws -> SkinsPanelLayout {
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
            
            guard let storefront = storefrontResponse.SkinsPanelLayout else {
                throw APIError.invalidCredentials
            }
            
            return storefront
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
   
    
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

    
    static func setCookie(named name: String, to value: String) async throws -> Void{
        WebService.session.configuration.httpCookieStorage!.setCookie(.init(properties: [
            .name: name,
            .value: value,
            .path: "/",
            .domain: "auth.riotgames.com",
        ])!)
    }

     
}


