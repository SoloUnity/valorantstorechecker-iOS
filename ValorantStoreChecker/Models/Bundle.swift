//
//  Bundle.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-18.
//

import Foundation



// MARK: - DataClass
struct BundleData: Codable {
    let uuid, displayName: String
    let displayNameSubText: JSONNull?
    let dataDescription: String
    let extraDescription, promoDescription: JSONNull?
    let useAdditionalContext: Bool
    let displayIcon, displayIcon2, verticalPromoImage: String
    let assetPath: String

    enum CodingKeys: String, CodingKey {
        case uuid, displayName, displayNameSubText
        case dataDescription = "description"
        case extraDescription, promoDescription, useAdditionalContext, displayIcon, displayIcon2, verticalPromoImage, assetPath
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
