//
//  UpdateModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-10.
//  From https://stackoverflow.com/a/68942888
//  http://itunes.apple.com/lookup?bundleId=com.solounity.ValorantStoreChecker

import Foundation
import SwiftUI

class UpdateModel: ObservableObject{
    
    @Published var update : Bool = false
    @AppStorage("showUpdate") var showUpdate : Bool = true
    let defaults = UserDefaults.standard
    
    init() {
        
        if showUpdate {
            let _ = try? isUpdateAvailable {[self] (update, error) in
                if let error = error {
                    print(error)
                } else if update ?? false {

                    DispatchQueue.main.async{
                        withAnimation(.easeIn) {
                            self.update = true
                        }
                    }
                }
            }
        }
    }
    

    @discardableResult
    func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error { throw error }
                
                guard let data = data else { throw VersionError.invalidResponse }
                            
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                            
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let lastVersion = result["version"] as? String, let releaseNotes =  result["releaseNotes"] as? String else {
                    throw VersionError.invalidResponse
                }
                
                let splitReleaseNotes = releaseNotes.split(separator: "\n")
                self.defaults.setValue(splitReleaseNotes, forKey: "releaseNotes")
                self.defaults.setValue(currentVersion, forKey: "currentVersion")
                self.defaults.setValue(lastVersion, forKey: "lastVersion")
                
                completion(lastVersion > currentVersion, nil)
                
                
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
        return task
    }

}
