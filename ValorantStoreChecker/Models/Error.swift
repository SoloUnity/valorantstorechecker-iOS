//
//  Error.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-26.
//

import Foundation

// Errors
enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
    case serverError
    case invalidURL
    case noData
    case decodingError
}


enum APIError: Error{
    case invalidURL
    case dataTaskError(String)
    case invalidResponseStatus
}
