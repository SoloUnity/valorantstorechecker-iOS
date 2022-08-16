//
//  Owned.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-16.
//

import Foundation


struct Owned: Codable {
    let itemTypeID: String
    let entitlements: [SkinEntitlement]?

    enum CodingKeys: String, CodingKey {
        case itemTypeID = "ItemTypeID"
        case entitlements = "Entitlements"
    }
}

struct SkinEntitlement: Codable {
    let typeID : String
    let itemID : String
    
    enum CodingKeys: String, CodingKey {
        case typeID = "TypeID"
        case itemID = "ItemID"
    }
}
