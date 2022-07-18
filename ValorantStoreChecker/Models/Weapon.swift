//
//  Weapon.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import Foundation

struct Weapon: Decodable, Identifiable{
    
    var id:UUID?
    var status:Int?
    var data:Data?
}

struct Data: Decodable, Identifiable{
    var id:String?
    var displayName:String?
    var themeUuid:String?
    var contentTierUuid:String?
    var displayIcon:String?
    var wallpaper:String?
    var assetPath:String?
    var chromas: Chromas?
    var levels: Levels?
    
    enum CodingKeys: String, CodingKey{
        case id = "uuid"
        
        case displayName
        case themeUuid
        case contentTierUuid
        case displayIcon
        case wallpaper
        case assetPath
        case chromas
        case levels
    }
    
}

struct Chromas: Decodable, Identifiable{
    var id:String?
    var displayName:String?
    var displayIcon:String?
    var fullRender:String?
    var swatch:String?
    var streamedVideo:String?
    var assetPath:String?
    
    enum CodingKeys: String, CodingKey{
        case id = "uuid"
        
        case displayName
        case displayIcon
        case fullRender
        case swatch
        case streamedVideo
        case assetPath
        
    }
}

struct Levels: Decodable, Identifiable{
    var id:String?
    var displayName:String?
    var levelItem:String?
    var displayIcon:String?
    var streamedVideo:String?
    var assetPath:String?
    
    enum CodingKeys: String, CodingKey{
        case id = "uuid"
        
        case displayName
        case levelItem
        case displayIcon
        case streamedVideo
        case assetPath
        
    }
    
}
