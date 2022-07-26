//
//  WebService.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made using https://www.youtube.com/watch?v=iXG3tVTZt6o tutorial
// watch https://www.youtube.com/watch?v=QrTChgzseVk
// https://www.youtube.com/watch?v=-4gbUyZZZgs

import Foundation

enum AuthenticationError: Error{
    case invalidCredentials
    case custom(errorMessage: String)
    case serverError
}

enum NetworkError: Error{
    case invalidURL
    case noData
    case decodingError
}

struct AuthCookies: Encodable{
    let client_id = "play-valorant-web-prod"
    let nonce = 1 // Yo what is a nonce
    let redirect_uri = "https://playvalorant.com/opt_in"
    let response_type = "token id_token"
}

struct AuthRequestBody: Encodable{
    let type = "auth"
    let username = "rintohsakalover69"
    let password = "Banana11!!!"
    let remember = "true"
}

struct AuthResponse: Codable{
    let uri:String?
}


class WebService{
    
    
    func getAllAccounts(token:String, completion: @escaping(Result<[Account], NetworkError>) -> Void){
        
        guard let url = URL(string: "https://strong-spangled-apartment.glitch.me/accounts") else{
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
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
    
    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        
        guard let url = URL(string: "https://auth.riotgames.com/api/v1/authorization") else{
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        
        
        let cookieBody = AuthCookies()
        
        // Create cookie request
        var cookieRequest = URLRequest(url: url)
        cookieRequest.httpMethod = "POST"
        cookieRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        cookieRequest.httpBody = try? JSONEncoder().encode(cookieBody)
        
        
        // Perform cookie request, from https://stackoverflow.com/a/29596772
        let cookieTask = URLSession.shared.dataTask(with: cookieRequest){ data, request, error in
            
            
            let cookieName = "MYCOOKIE"
            if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == cookieName }) {
                print("\(cookieName): \(cookie.value)")
            }
            
            
            /*
            guard
                    let url = request?.url,
                    let httpResponse = request as? HTTPURLResponse,
                    let fields = httpResponse.allHeaderFields as? [String: String]
                        
                else { return }

                let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
                HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                for cookie in cookies {
                    var cookieProperties = [HTTPCookiePropertyKey: Any]()
                    cookieProperties[.name] = cookie.name
                    cookieProperties[.value] = cookie.value
                    cookieProperties[.domain] = cookie.domain
                    cookieProperties[.path] = cookie.path
                    cookieProperties[.version] = cookie.version
                    cookieProperties[.expires] = Date().addingTimeInterval(3600)

                    let newCookie = HTTPCookie(properties: cookieProperties)
                    HTTPCookieStorage.shared.setCookie(newCookie!)
                }
             */
             
            
        }
        
        cookieTask.resume()
        
        let asidCookie = HTTPCookieStorage.shared.cookies![2].value
        print(asidCookie)
        let requestBody = AuthRequestBody(/*username: username, password: password*/)
        
        var authRequest = URLRequest(url: url)
        authRequest.httpMethod = "PUT"
        authRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //authRequest.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: [cookies[2]]) // From https://stackoverflow.com/questions/41612937/cookies-setting-automatically-in-swift
        authRequest.addValue("asid=\(asidCookie)", forHTTPHeaderField: "Cookie")
        authRequest.httpBody = try? JSONEncoder().encode(requestBody)
    
        
        
        // Retrieve token
        let authTask = URLSession.shared.dataTask(with: authRequest){ data, request, error in
            
            print(String(data: data!, encoding: .utf8))
            /*
            // Create data
            guard let data = data, error == nil else{
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            
            // Decode incoming auth response json
            guard let loginResponse = try? JSONDecoder().decode(AuthResponse.self, from: data) else{
                completion(.failure(.invalidCredentials))
                return
            }
            
            // Use login response to get the token
            guard let token = loginResponse.uri else{
                completion(.failure(.invalidCredentials))
                return
            }
            
            print(token)
            
            // Successful token received
            completion(.success(token))
            */
        }
        authTask.resume()
    }
}


