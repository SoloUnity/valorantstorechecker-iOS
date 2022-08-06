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
