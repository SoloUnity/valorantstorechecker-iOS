//
//  Weapon.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import Foundation



class Skin: Identifiable, Codable, ObservableObject{
    
    @Published var imageData: Data?
    
    var id : UUID
    var displayName:String
    var themeUuid:String?
    var contentTierUuid:String?
    var displayIcon:String?
    //var wallpaper:String?
    //var assetPath:String?
    var chromas: [Chromas]?
    var levels: [Levels]?
    
    enum CodingKeys:String, CodingKey{
        case id = "uuid"
        
        case displayName
        case themeUuid
        case contentTierUuid
        case displayIcon
        //case wallpaper
        //case assetPath
        case chromas
        case levels
    }
    
    // Convert image url to data object
    
     func getImageData() {
         
         if let url = URL(string: "\(Constants.URL.valStore)weaponskinlevels/\(levels!.first!.id.description.lowercased()).png") {
             
             
             // Get a session
             let session = URLSession.shared
             let dataTask = session.dataTask(with: url) { (data, response, error) in
                 
                 if error == nil {
                     
                     DispatchQueue.main.async {
                         // Set the image data
                         self.imageData = data!
                     }
                 }
             }
             dataTask.resume()
         }
        
     }
}

struct Chromas: Codable, Identifiable{
    
    var id : UUID
    var displayName:String?
    var displayIcon:String?
    var fullRender:String?
    //var swatch:String?
    var streamedVideo:String?
    //var assetPath:String?
    
    enum CodingKeys:String, CodingKey{
        case id = "uuid"
        
        case displayName
        case displayIcon
        case fullRender
        case streamedVideo
    }

}

struct Levels: Codable, Identifiable{
    
    var id:UUID
    var displayName:String?
    var levelItem:String?
    var displayIcon:String?
    var streamedVideo:String?
    //var assetPath:String?
    
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
