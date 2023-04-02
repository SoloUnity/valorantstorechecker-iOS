//
//  Error.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-26.
//

import Foundation

enum APIError: Error {
    case invalidURL // 1
    case dataTaskError(String) // 2
    case invalidResponseStatus //3
    case noData // 4
    case invalidCredentials //5
    
}

enum CookieError: Error {
    case invalidURL // 1
    case invalidResponseStatus // 2
    case dataTaskError(String) // 3
}

enum CookieReloadError: Error {
    case invalidURL // 1
    case invalidResponseStatus 
    case badDecode
    case badURI
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
    case invalidURL // 1
    case invalidResponseStatus // 2
    case badDecode // 3
    case noData // 4
    case dataTaskError(String) // 5
}

enum BundleListError: Error {
    case invalidList
}

enum VersionError: Error {
    case invalidResponse
    case invalidBundleInfo
}

enum JSONDownloadError : Error {
    case invalidResponse
    case invalidJson
}

enum ImageDownloadError : Error {
    case invalidResponse
    case invalidJson
}
