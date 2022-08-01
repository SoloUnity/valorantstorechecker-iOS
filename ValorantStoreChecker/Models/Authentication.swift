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
    let type : String?
    let response: Response?
    let multifactor: Multifactor?
}

struct Response : Codable {
    let parameters: URI?
}

// Token url, access via acess_token in response
struct URI: Codable {
    let uri : String?
}

// Multifactor
struct Multifactor: Codable {
    let email : String?
}

struct MultifactorBody: Encodable {
    let type = "multifactor"
    let code : String
    let rememberDevice = true
}

// Entitlement
struct Entitlement: Decodable{
    let entitlements_token : String?
}

// PUUID
struct PUUID: Codable{
    let sub : String?
}
