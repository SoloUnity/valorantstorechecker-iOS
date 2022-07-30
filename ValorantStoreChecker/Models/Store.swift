//
//  Account.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made using https://app.quicktype.io

import Foundation


struct Storefront: Codable {
    let SkinsPanelLayout : SkinsPanelLayout?
}

struct SkinsPanelLayout: Codable {
    let SingleItemOffers : [String]?
    let SingleItemOffersRemainingDurationInSeconds : Int?
}


struct StorePrice: Codable {
    let offers: [Offer]?

    enum CodingKeys: String, CodingKey {
        case offers = "Offers"
    }
}

struct Offer: Codable {
    let offerID: String?
    let isDirectPurchase: Bool?
    let startDate: String?
    let cost: Cost?

    enum CodingKeys: String, CodingKey {
        case offerID = "OfferID"
        case isDirectPurchase = "IsDirectPurchase"
        case startDate = "StartDate"
        case cost = "Cost"
    }
}

struct Cost: Codable {
    let price: Int

    enum CodingKeys: String, CodingKey {
        case price = "85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741"
    }
}


