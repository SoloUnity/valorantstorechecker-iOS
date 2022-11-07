//
//  Weapon.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import Foundation
import UIKit

class Skin: Identifiable, Codable, ObservableObject{
    
    var id : UUID
    var displayName:String
    var themeUuid:String?
    var contentTierUuid:String?
    var displayIcon:String?
    var chromas: [Chromas]?
    var levels: [Levels]?
    var assetPath : String?
    var discountedCost : String?
    
    enum CodingKeys:String, CodingKey{
        case id = "uuid"
        
        case displayName
        case themeUuid
        case contentTierUuid
        case displayIcon
        case chromas
        case levels
        case assetPath
        case discountedCost
    }
    
}

struct Chromas: Codable, Identifiable{
    
    var id : UUID
    var displayName:String?
    var displayIcon:String?
    var fullRender:String?
    var streamedVideo:String?
    let swatch : String?
    
    enum CodingKeys:String, CodingKey{
        case id = "uuid"
        
        case displayName
        case displayIcon
        case fullRender
        case streamedVideo
        case swatch
    }
    
}

struct Levels: Codable, Identifiable{
    
    var id:UUID
    var displayName:String?
    var levelItem:String?
    var displayIcon:String?
    var streamedVideo:String?
    
    enum CodingKeys:String, CodingKey{
        case id = "uuid"
        
        case displayName
        case levelItem
        case displayIcon
        case streamedVideo
    }
}

struct Skins: Codable {
    
    var data:[Skin]
    
}
/*
struct Skins: Codable, AsyncSequence {
    typealias Element = Skin
    
    var data:[Skin]
    
    init(data: [Skin]) {
        self.data = data
    }
    
    func makeAsyncIterator() -> DataIterator {
        return DataIterator(data: data)
    }
}

struct DataIterator: AsyncIteratorProtocol {
    typealias Element = Skin
    
    var index = 0
    var data:[Skin]
    
    mutating func next() async throws -> Skin? {
        guard index < data.count else {
            return nil
        }
        
        let skin = data[index]
        index += 1
        
        return skin
    }
    
}
*/

