//
//  Error.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-26.
//

import Foundation

enum APIError: Error{
    case invalidURL
    case dataTaskError(String)
    case invalidResponseStatus
    case noData
    case invalidCredentials
}

enum CookieError: Error {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
}

enum TokenError: Error {
    case invalidURL
    case invalidResponseStatus
    case invalidCredentials
    case dataTaskError(String)
    case badURI
}

enum MultifactorError: Error {
    case invalidURL
    case invalidResponseStatus
    case invalidCredentials
    case dataTaskError(String)
    case badURI
}

enum EntitlementError: Error {
    case invalidURL
    case invalidCredentials
    case invalidResponseStatus
    case badDecode
    case dataTaskError(String)
}

enum PlayerError : Error {
    case invalidURL
    case invalidResponseStatus
    case badDecode
    case noData
    case dataTaskError(String)
}

enum StorefrontError: Error {
    case invalidURL
    case invalidResponseStatus
    case badDecode
    case dataTaskError(String)
}

enum BundleError : Error {
    case invalidURL
    case invalidResponseStatus
    case badDecode
    case dataTaskError(String)
}

enum PriceError : Error {
    case invalidURL
    case invalidResponseStatus
    case badDecode
    case noData
    case dataTaskError(String)
}

enum WalletError : Error {
    case invalidURL
    case invalidResponseStatus
    case badDecode
    case noData
    case dataTaskError(String)
}

enum CookieAuthError : Error {
    case invalidURL
    case invalidResponseStatus
    case noData
    case dataTaskError(String)
}

enum OwnedError : Error {
    case invalidURL
    case invalidResponseStatus
    case badDecode
    case noData
    case dataTaskError(String)
}
