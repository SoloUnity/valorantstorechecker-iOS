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
    
    init() {
        
        let bundleLang = Bundle.main.preferredLocalizations
        
        if bundleLang[0] != defaults.string(forKey: "currentLanguage") {
            
            defaults.set(bundleLang[0], forKey: "currentLanguage")
            
        }
        
        print(bundleLang)
        
        Task {
            await getRemoteData(language: bundleLang[0])
        }
        
        getLocalData()

    }
    
    func getLocalData() {
        
        if let skinData = defaults.data(forKey: "skinDataResponse") {
            
            guard let skinDataResponse = try? JSONDecoder().decode(Skins.self, from: skinData) else {
                return
            }
            
            self.data = skinDataResponse.data.sorted(by: {$0.displayName.lowercased() < $1.displayName.lowercased()}).filter({!$0.displayName.contains("Standard")}).filter{$0.displayName != "Melee"}.filter{$0.displayName != "Random Favorite Skin"} //Sorts alphabetically and filters out Standard skin
        }
        else {

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
        
    }
    
    @MainActor
    func getRemoteData(language: String) async {
        
        var urlString = Constants.URL.valAPISkins
        
        var chosenLanguage = ""
        
        switch language {
        case "fr","fr-CA":
            chosenLanguage = "fr-FR"
        case "ja":
            chosenLanguage = "ja-JP"
        case "ko":
            chosenLanguage = "ko-KR"
        case "de":
            chosenLanguage = "de-DE"
        case "zh-Hans":
            chosenLanguage = "zh-CN"
        default:
            chosenLanguage = "en-US"
        }
        
        urlString = urlString + "?language=" + chosenLanguage
        print(urlString)
        
        let url = URL(string: urlString)
        
        do {
            
            // Create authentication request
            let skinDataDownload = URLRequest(url: url!)
            
            // API Call
            let (data , response) = try await WebService.session.data(for: skinDataDownload)
            
            // Save the data
            defaults.set(data, forKey: "skinDataResponse")
            
            // Verify server request
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else{
                throw JSONDownloadError.invalidResponse
            }
            
            
            guard let skinDataResponse = try? JSONDecoder().decode(Skins.self, from: data) else {
                throw JSONDownloadError.invalidJson
            }
            
            
            
            if UserDefaults.standard.bool(forKey: "authorizeDownload") {
                
                let session = URLSession.shared
                
                for skin in skinDataResponse.data {
                    
                    self.getImageLevelData(skin: skin, session: session)
                    self.getImageChromaData(skin: skin, session: session)
                    
                }
            }
            
            // Background thread
            DispatchQueue.main.async{
                self.data = skinDataResponse.data.sorted(by: {$0.displayName.lowercased() < $1.displayName.lowercased()}).filter({!$0.displayName.contains("Standard")}).filter{$0.displayName != "Melee"}.filter{$0.displayName != "Random Favorite Skin"} //Sorts alphabetically and filters out Standard skin
            }
            
        }
        catch {
            return
        }
    }
    
    // Convert image url to data object
    func getImageLevelData(skin: Skin, session: URLSession) {
        
        if let _ = defaults.data(forKey: skin.levels!.first!.id.description) {
            
        } else {
            if let url = URL(string: "\(Constants.URL.valStore)weaponskinlevels/\(skin.levels!.first!.id.description.lowercased()).png") {
                
                dataHelper(url: url, key: skin.levels!.first!.id.description, session: session)
                
            }

        }
    }

    func getImageChromaData(skin: Skin, session: URLSession) {
        
        for chroma in skin.chromas! {
            
            if let _ = defaults.data(forKey: chroma.id.description) {
                
            } else {
                if let url = URL(string: "\(Constants.URL.valAPIMedia)weaponskinchromas/\(chroma.id.description.lowercased())/fullrender.png") {
                    
                    dataHelper(url: url, key: chroma.id.description, session: session)
                }
            }
            
            if let _ = defaults.data(forKey: chroma.id.description + "swatch") {
                
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
     
   
    


    

