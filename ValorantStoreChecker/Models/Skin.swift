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
    
    enum CodingKeys:String, CodingKey{
        case id = "uuid"
        
        case displayName
        case themeUuid
        case contentTierUuid
        case displayIcon
        case chromas
        case levels
        case assetPath
    }
    
    // Convert image url to data object
    
    func getImageLevelData() {
        
        if let _ = UserDefaults.standard.data(forKey: self.levels!.first!.id.description) {
            
        } else {
            if let url = URL(string: "\(Constants.URL.valStore)weaponskinlevels/\(levels!.first!.id.description.lowercased()).png") {
                
                dataHelper(url: url, key: self.levels!.first!.id.description)
                
            }
            else if let url = URL(string: "\(Constants.URL.valAPIMedia)weaponskinlevels/\(levels!.first!.id.description.lowercased())/fullrender.png") {
                
                dataHelper(url: url, key: self.levels!.first!.id.description)
                
            }
            else if let url = URL(string: "\(Constants.URL.valAPIMedia)weaponskinlevels/\(levels!.first!.id.description.lowercased())/displayicon.png") {
                
                dataHelper(url: url, key: self.levels!.first!.id.description)
                
            }
            else if let url = URL(string: "\(Constants.URL.valStore)weaponskinlevels/\(levels!.first!.id.description.lowercased()).png") {
                
                dataHelper(url: url, key: self.levels!.first!.id.description)
                
            }
        }
        
    }

    func getImageChromaData() {
        
        for chroma in self.chromas! {
            
            if let _ = UserDefaults.standard.data(forKey: chroma.id.description) {
                
            } else {
                if let url = URL(string: "\(Constants.URL.valAPIMedia)weaponskinchromas/\(chroma.id.description.lowercased())/fullrender.png") {
                    
                    
                    dataHelper(url: url, key: chroma.id.description)
                    
                }
                else if let url = URL(string: "\(Constants.URL.valAPIMedia)weaponskinchromas/\(chroma.id.description.lowercased())/displayicon.png") {
                    
                    dataHelper(url: url, key: chroma.id.description)
                    
                }
                else if let url = URL(string: "\(Constants.URL.valStore)weaponskinchromas/\(chroma.id.description.lowercased()).png") {
                    
                    dataHelper(url: url, key: chroma.id.description)
                }
                
            }
        }
        
    }
    
    func dataHelper (url : URL, key : String) {
        // Get a session
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                return
            }
            
            if error == nil {
                
                DispatchQueue.main.async {
                    // Set the image data
                    if data != nil {
                        let encoded = try! PropertyListEncoder().encode(data)
                        UserDefaults.standard.set(encoded, forKey: key)
                    }
                }
            }
        }
        dataTask.resume()
    }
}

struct Chromas: Codable, Identifiable{
    
    var id : UUID
    var displayName:String?
    var displayIcon:String?
    var fullRender:String?
    var streamedVideo:String?
    
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
