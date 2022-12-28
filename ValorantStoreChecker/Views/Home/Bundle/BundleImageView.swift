//
//  BundleImageView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-20.
//

import SwiftUI

struct BundleImageView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    let defaults = UserDefaults.standard
    let bundleIndex : Int
    var body: some View {
        ZStack{
            

            if authAPIModel.bundleImage != [] {
                
                // Quicker load time but a data muncher
                AsyncImage(url: URL(string: authAPIModel.bundleImage[bundleIndex - 1])) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                }
                placeholder: {
                    
                    if let imageData = defaults.data(forKey: "bundleDisplayIcon" + String(bundleIndex)) {
                        
                        let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData )
                        
                        let uiImage = UIImage(data: decoded)
                        
                        ZStack {
                            
                            Image(uiImage: uiImage ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                
                            
                            ProgressView()
                        }
                        
                        
                        
                    }
                    else {
                        ProgressView()
                    }
                    
                }
            }
            else if let imageData = defaults.data(forKey: "bundleDisplayIcon" + String(bundleIndex)) {
                
                let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData )
                
                let uiImage = UIImage(data: decoded)
                
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }

            
        }
        
    }
}

