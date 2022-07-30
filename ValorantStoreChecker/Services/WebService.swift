//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made with the help of https://github.com/juliand665


import Foundation

struct WebService {
    // Common URLSession
    static let session: URLSession = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = 30 // seconds
            configuration.timeoutIntervalForResource = 30 // seconds
            return URLSession(configuration: configuration)
    }()
    
    
    static func getCookies() async throws -> String {
        guard let url = URL(string: Constants.URL.auth) else{
            throw APIError.invalidURL
        }
        
        
        do{
            let cookieBody = AuthCookies()
            
            // Create cookie request
            var cookieRequest = URLRequest(url: url)
            cookieRequest.httpMethod = "POST"
            cookieRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            cookieRequest.httpBody = try! JSONEncoder().encode(cookieBody)
            
            
            let (data,response) = try await session.data(for: cookieRequest)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw APIError.invalidResponseStatus
            }
            
            let cookie = String(data: data, encoding: .utf8)
            print(cookie!)
            return cookie!
            
        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
    }
    
    
    func getToken(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){
        guard let url = URL(string: Constants.URL.auth) else{
            completion(.failure(.invalidURL))
            return
        }
        
        let requestBody = AuthRequestBody(username: username, password: password)
        
        var authRequest = URLRequest(url: url)
        authRequest.httpMethod = "PUT"
        authRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        authRequest.httpBody = try! JSONEncoder().encode(requestBody)
        

        // Retrieve token
        let authTask = WebService.session.dataTask(with: authRequest){ data, request, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let uri = authResponse.response?.parameters?.uri else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            
            // Funny way to get the token
            // TODO: Do this but better
            let split = uri.split(separator: "=")
            let token = String(split[1].split(separator: "&")[0])


            
            completion(.success(token))
        }
        authTask.resume()
    }
    
    
    func getRiotEntitlement(token: String, completion: @escaping(Result<String ,AuthenticationError>) -> Void){
        guard let url = URL(string: Constants.URL.entitlement) else{
            completion(.failure(.invalidURL))
            return
        }
        
        var entitlementRequest = URLRequest(url: url)
        entitlementRequest.httpMethod = "POST"
        entitlementRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        entitlementRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform cookie request, from https://stackoverflow.com/a/29596772
        let entitlementTask = WebService.session.dataTask(with: entitlementRequest){ data, request, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            guard let entitlementResponse = try? JSONDecoder().decode(Entitlement.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let riotEntitlement = entitlementResponse.entitlements_token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
        completion(.success(riotEntitlement))
        }
        entitlementTask.resume()
    }
    
    func getPlayerInfo(token:String, completion: @escaping(Result<String, AuthenticationError>) -> Void){
        guard let url = URL(string: Constants.URL.playerInfo) else{
            completion(.failure(.invalidURL))
            return
        }
        
        
        var puuidRequest = URLRequest(url: url)
        puuidRequest.httpMethod = "GET"
        puuidRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        let puuidTask = WebService.session.dataTask(with: puuidRequest){ data, request, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            guard let puuidResponse = try? JSONDecoder().decode(PUUID.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let puuid = puuidResponse.sub else {
                completion(.failure(.invalidCredentials))
                return
            }
            
        completion(.success(puuid))
        }
        puuidTask.resume()
        
    }
    
    func getStorefront(token:String, riotEntitlement: String, puuid: String, region: String, completion: @escaping(Result<[String], AuthenticationError>) -> Void){
        
        guard let url = URL(string: "https://pd.\(region).a.pvp.net/store/v2/storefront/\(puuid)") else{
            completion(.failure(.invalidURL))
            return
        }
        
        var storefrontRequest = URLRequest(url: url)
        storefrontRequest.httpMethod = "GET"
        storefrontRequest.addValue(riotEntitlement, forHTTPHeaderField: "X-Riot-Entitlements-JWT")
        storefrontRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        let storefrontTask = WebService.session.dataTask(with: storefrontRequest){ data, request, error in
    
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            
            guard let storefrontResponse = try? JSONDecoder().decode(Storefront.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let storefront = storefrontResponse.SkinsPanelLayout!.SingleItemOffers else {
                completion(.failure(.invalidCredentials))
                return
            }
            
        completion(.success(storefront))
        }
        storefrontTask.resume()
        
    }
    
    func getStorePrices(token:String, completion: @escaping(Result<String, AuthenticationError>) -> Void){
        
    }
    

    /*
    func logout() async{
        await WebService.session.flush()
    }
     */
     
}


