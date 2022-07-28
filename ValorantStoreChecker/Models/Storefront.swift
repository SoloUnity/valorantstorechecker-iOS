//
//  Account.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation

struct Storefront: Codable {
    let SkinsPanelLayout : SkinsPanelLayout?
}

struct SkinsPanelLayout: Codable{
    let SingleItemOffers : [String]?
}
