//
//  ContentModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import Foundation

class SkinModel: ObservableObject{
    
    @Published var data : [Skin] = []
    @Published var errorMessage = "" 
    
    let defaults = UserDefaults.standard
    
    init () {
        
        getLocalData()
        getRemoteData()

    }
    
    // I did not learn about async/await when I made this stop laughing at me
    
    func getLocalData() {
        
        // Local json file
        let jsonUrl = Bundle.main.url(forResource: "SkinData", withExtension: "json")
        
        do{
            
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode json into an array of modules
            let jsonDecoder = JSONDecoder()
            
            // get jsonDecode.decode(type, from) type is what you want obtained from the jsonData you input
            let skinList = try jsonDecoder.decode(Skins.self, from: jsonData)
            
            // Assign parse modules to modules property, updates @Published data
            self.data = skinList.data.sorted(by: {$0.displayName.lowercased() < $1.displayName.lowercased()}).filter({!$0.displayName.contains("Standard")}).filter{$0.displayName != "Melee"}.filter{$0.displayName != "Random Favorite Skin"} //Sorts alphabetically and filters out Standard skin
            
        }
        catch{
            print("Rip JSON doesn't work")
        }
         
    }
    
    func getRemoteData(){
        
        // String path
        let urlString = Constants.URL.valAPISkins
        
        // URL object
        let url = URL(string: urlString)
        
        guard url != nil else{
            // Couldnt create url
            return
        }
        
        // URLRequest object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
        
        // Create Data Task
        let dataTask = session.dataTask(with: request){ data, response, error in
            
            // Check if there is an error
            guard error == nil else{
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("404")
                return
            }
            
            // Handle response
            let jsonDecoder = JSONDecoder()
            let skinList = try! jsonDecoder.decode(Skins.self, from: data!)
            
            let session = URLSession.shared
            
            for skin in skinList.data{
                DispatchQueue.global(qos: .userInteractive).async {
                    
                    self.getImageLevelData(skin: skin, session: session)
                    self.getImageChromaData(skin: skin, session: session)
                    
                    
                }
            }
            
            
            // Background thread
            DispatchQueue.main.async{
                self.data = skinList.data.sorted(by: {$0.displayName.lowercased() < $1.displayName.lowercased()}).filter({!$0.displayName.contains("Standard")}).filter{$0.displayName != "Melee"}.filter{$0.displayName != "Random Favorite Skin"} //Sorts alphabetically and filters out Standard skin
            }
            
        }
        // Kick off data task
        dataTask.resume()
        
    }
    // Convert image url to data object
    
    func getImageLevelData(skin: Skin, session: URLSession) {
        
        if let _ = UserDefaults.standard.data(forKey: skin.levels!.first!.id.description) {
            
        } else {
            if let url = URL(string: "\(Constants.URL.valStore)weaponskinlevels/\(skin.levels!.first!.id.description.lowercased()).png") {
                
                dataHelper(url: url, key: skin.levels!.first!.id.description, session: session)
                
            }

        }
    }

    func getImageChromaData(skin: Skin, session: URLSession) {
        
        for chroma in skin.chromas! {
            
            if let _ = UserDefaults.standard.data(forKey: chroma.id.description) {
                
            } else {
                if let url = URL(string: "\(Constants.URL.valAPIMedia)weaponskinchromas/\(chroma.id.description.lowercased())/fullrender.png") {
                    
                    dataHelper(url: url, key: chroma.id.description, session: session)
                }
            }
            
            if let _ = UserDefaults.standard.data(forKey: chroma.id.description + "swatch") {
                
            } else {
                
                guard let swatchURL = chroma.swatch else {
                    return
                }
                
                if let url = URL(string: swatchURL) {
                    
                    dataHelper(url: url, key: chroma.id.description + "swatch", session: session)
                }
            }
        }
    }
    
    func dataHelper (url : URL, key : String, session: URLSession) {
        // Get a session
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
     
   
    


    

