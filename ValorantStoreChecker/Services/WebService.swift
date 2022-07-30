//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made with the help of https://github.com/juliand665
//  Used https://github.com/techchrism/valorant-api-docs/tree/trunk/docs for docs


import Foundation

struct WebService {
    // Common URLSession
    static let session: URLSession = {
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
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                throw APIError.invalidCredentials
            }
            
            guard let uri = authResponse.response?.parameters?.uri else {
                throw APIError.invalidCredentials
            }
            
            
            // Split uri and obtain access token
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

    static func getStorefront(token:String, riotEntitlement: String, puuid: String, region: String) async throws -> [String] {
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
            
            guard let storefront = storefrontResponse.SkinsPanelLayout!.SingleItemOffers else {
                throw APIError.invalidCredentials
            }
            
            return storefront
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
   
    
    func getStorePrices(token:String, completion: @escaping(Result<String, AuthenticationError>) -> Void){
        
    }
    

    /*
    func logout() async{
        await WebService.session.flush()
    }
     */
     
}


