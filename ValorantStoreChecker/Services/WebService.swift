//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made with the help of https://github.com/juliand665


import Foundation

class WebService {
    // Common URLSession
    static let session: URLSession = {
            let configuration = URLSessionConfiguration.ephemeral
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
        guard let url = URL(string: Constants.URL.auth) else{
            completion(.failure(.custom(errorMessage: "Bad URL")))
            return
        }
        
        let cookieBody = AuthCookies()
        
        // Create cookie request
        var cookieRequest = URLRequest(url: url)
        cookieRequest.httpMethod = "POST"
        cookieRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        cookieRequest.httpBody = try! JSONEncoder().encode(cookieBody)
        
        
        // Perform cookie request, from https://stackoverflow.com/a/29596772
        let cookieTask = WebService.session.dataTask(with: cookieRequest){ data, request, error in
        let data = String(data: data!, encoding: .utf8)
        completion(.success(data!))
        }
        cookieTask.resume()
    }
    
    func getToken(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){
        guard let url = URL(string: Constants.URL.auth) else{
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
    
    func getEntitlement(){
        
    }
    
    /*
    func logout() async{
        await WebService.session.flush()
    }
     */
}


