//
//  Bundle.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-18.
//

import Foundation


struct BundleResponse: Codable {
    let status: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let uuid : String
    let displayName : String
    let displayIcon : String
}


// valstore API


// MARK: - Welcome
struct ValStoreBundle: Codable {
    let status: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let name: String
    let price: Int
}


