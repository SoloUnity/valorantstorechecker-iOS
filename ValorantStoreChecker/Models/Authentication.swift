//
//  Authentication.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-26.
//

import Foundation

// Cookies
struct AuthCookies: Encodable {
    let client_id = "play-valorant-web-prod"
    let nonce = 1 // Yo what is a nonce
    let redirect_uri = "https://playvalorant.com/opt_in"
    let response_type = "token id_token"
}

// Authentication
struct AuthRequestBody: Encodable {
    let type = "auth"
    let username : String
    let password : String
    let remember = true
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

// Entitlement
struct Entitlement: Decodable{
    let entitlements_token : String?
}

// PUUID
struct PUUID: Codable{
    let sub : String?
}
