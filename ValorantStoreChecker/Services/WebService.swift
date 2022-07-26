//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made using https://www.youtube.com/watch?v=iXG3tVTZt6o tutorial
// watch https://www.youtube.com/watch?v=QrTChgzseVk
// https://www.youtube.com/watch?v=-4gbUyZZZgs

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
    case serverError
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct AuthCookies: Encodable {
    let client_id = "play-valorant-web-prod"
    let nonce = 1 // Yo what is a nonce
    let redirect_uri = "https://playvalorant.com/opt_in"
    let response_type = "token id_token"
}

struct AuthRequestBody: Encodable {
    let type = "auth"
    let username = "rintohsakalover69"
    let password = "Banana11!!!"
    let remember = "true"
}

struct AuthResponse: Codable {
    let response: Response?
}

struct Response : Codable {
    let parameters: URI?
}

struct URI: Codable {
    let uri : String?
}



class WebService {
    static let sessionManager: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30 // seconds
            configuration.timeoutIntervalForResource = 30 // seconds
            return URLSession(configuration: configuration)
    }()
    
    func getAllAccounts(token:String, completion: @escaping(Result<[Account], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/accounts") else{
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else{
                completion(.failure(.noData))
                return
            }
            
            guard let accounts = try? JSONDecoder().decode([Account].self, from: data) else{
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
        }.resume()
        
    }
    
    
    
    func getCookies(completion: @escaping(Result<String ,AuthenticationError>) -> Void){
        guard let url = URL(string: "https://auth.riotgames.com/api/v1/authorization") else{
            completion(.failure(.custom(errorMessage: "Bad URL")))
            return
        }
        
        let cookieBody = AuthCookies()
        
        // Create cookie request
        var cookieRequest = URLRequest(url: url)
        cookieRequest.httpMethod = "POST"
        cookieRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        cookieRequest.httpBody = try? JSONEncoder().encode(cookieBody)
        
        
        // Perform cookie request, from https://stackoverflow.com/a/29596772
        let cookieTask = WebService.sessionManager.dataTask(with: cookieRequest){ data, request, error in
            let data = String(data: data!, encoding: .utf8)
            completion(.success(data!))
        }
        cookieTask.resume()
    }
    
    func getToken(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){
        guard let url = URL(string: "https://auth.riotgames.com/api/v1/authorization") else{
            return
        }
        
        let requestBody = AuthRequestBody(/*username: username, password: password*/)
        
        var authRequest = URLRequest(url: url)
        authRequest.httpMethod = "PUT"
        authRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        authRequest.httpBody = try? JSONEncoder().encode(requestBody)
        

        // Retrieve token
        let authTask = WebService.sessionManager.dataTask(with: authRequest){ data, request, error in
            
            print(String(data: data!, encoding: .utf8))
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            try! JSONDecoder().decode(AuthResponse.self, from: data)
            
            guard let authResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = authResponse.response?.parameters?.uri else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
        }
        authTask.resume()
    }
    

}


