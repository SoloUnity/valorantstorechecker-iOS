//
//  Weapon.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import Foundation

struct Skin: Identifiable, Decodable{
    
    var id:UUID?
    var status:Int?
    var data:Data
    
}

struct Data: Decodable, Identifiable{
    
    var id:UUID?
    var uuid:String?
    var displayName:String?
    var themeUuid:String?
    var contentTierUuid:String?
    var displayIcon:String?
    var wallpaper:String?
    var assetPath:String?
    var chromas: [Chromas]
    var levels: [Levels]
    
    
    
}

struct Chromas: Decodable, Identifiable{
    
    var id:UUID?
    var uuid:String?
    var displayName:String?
    var displayIcon:String?
    var fullRender:String?
    var swatch:String?
    var streamedVideo:String?
    var assetPath:String?
    

}

struct Levels: Decodable, Identifiable{
    
    var id:UUID?
    var uuid:String?
    var displayName:String?
    var levelItem:String?
    var displayIcon:String?
    var streamedVideo:String?
    var assetPath:String?
    

    
}

