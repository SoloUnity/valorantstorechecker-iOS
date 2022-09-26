//
//  Account.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//  Made using https://app.quicktype.io

import Foundation


struct Storefront: Codable {
    let FeaturedBundle: FeaturedBundle?
    let SkinsPanelLayout : SkinsPanelLayout?
    let BonusStore : BonusStore?
}

// MARK: NightMarket
struct BonusStore: Codable {
    let BonusStoreOffers : [NightMarketItem]?
    let BonusStoreRemainingDurationInSeconds : Int?
}

struct NightMarketItem: Codable {
    let Offer : NightMarketOffer?
    let DiscountCosts : NightMarketDiscountCost?
}

struct NightMarketOffer : Codable {
    let OfferID : String?
}

struct NightMarketDiscountCost : Codable {
    let discountItemCost : Int?
    
    enum CodingKeys: String, CodingKey {
        case discountItemCost = "85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741"
    }
}

// MARK: Store
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

struct Wallet: Codable {
    let balances: Currency?

    enum CodingKeys: String, CodingKey {
        case balances = "Balances"
    }
}

struct Currency: Codable {
    let vp : Int?
    let rp : Int?
    
    enum CodingKeys: String, CodingKey {
        case vp = "85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741"
        case rp = "e59aa87c-4cbf-517a-5983-6e81511be9b7"
    }
}

// MARK: Featured Bundle
struct FeaturedBundle: Codable {
    let bundle: StoreBundle
    let bundles: [StoreBundle]
    

    enum CodingKeys: String, CodingKey {
        case bundle = "Bundle"
        case bundles = "Bundles"
    }
}


struct StoreBundle: Codable {
    let dataAssetID : String
    let items: [ItemElement]
    let durationRemainingInSeconds: Int
    
    enum CodingKeys: String, CodingKey {
        case dataAssetID = "DataAssetID"
        case items = "Items"
        case durationRemainingInSeconds = "DurationRemainingInSeconds"
    }
}


struct ItemElement: Codable {
    let item: ItemItem
    let discountedPrice: Int

    enum CodingKeys: String, CodingKey {
        case item = "Item"
        case discountedPrice = "DiscountedPrice"
    }
}

struct ItemItem: Codable {
    let itemTypeID, itemID: String

    enum CodingKeys: String, CodingKey {
        case itemTypeID = "ItemTypeID"
        case itemID = "ItemID"
    }
}

struct Storefronts: Codable {
    var data:[Storefront]
}
