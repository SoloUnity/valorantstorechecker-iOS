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

    init(){
        getLocalData()
        getRemoteData()
    }
    
    func getLocalData(){
        
        // Local json file
        let jsonUrl = Bundle.main.url(forResource: "SkinData", withExtension: "json")
        
        do{
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode json into an array of modules
            let jsonDecoder = JSONDecoder()
            
            // get jsonDecode.decode(type, from) type is what you want obtained from the jsonData you input
            let skinList = try jsonDecoder.decode(Skins.self, from: jsonData)
            
            // Call get image function
            for s in skinList.data{
                s.getImageData()
            }
            
            // Assign parse modules to modules property, updates @Published data
            self.data = skinList.data.sorted(by: {$0.displayName < $1.displayName}).filter({!$0.displayName.contains("Standard")}).filter({!$0.displayName.contains("Melee")}) //Sorts alphabetically and filters out Standard skin
        }
        catch{
            print("Rip JSON doesn't work")
        }
    }
    
    func getRemoteData(){
        
        // String path
        let urlString = "https://valorant-api.com/v1/weapons/skins"
        
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
                self.errorMessage = "Bad response"
                return
            }
            
            
            guard httpResponse.statusCode == 200 else {
                return
            }
            
            // Handle response
            let jsonDecoder = JSONDecoder()
            let skinList = try! jsonDecoder.decode(Skins.self, from: data!)
            
            // Call get image function
            for s in skinList.data{
                s.getImageData()
            }
            
            // Background thread
            DispatchQueue.main.async{
                self.data = skinList.data.sorted(by: {$0.displayName < $1.displayName}).filter({!$0.displayName.contains("Standard")}).filter({!$0.displayName.contains("Melee")}) //Sorts alphabetically and filters out Standard skin
            }

        }
        // Kick off data task
        dataTask.resume()
        
    }
    
    
    
 }
     
   
    


    

