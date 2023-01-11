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
        
        let imageData = defaults.data(forKey: "bundleDisplayIcon" + String(bundleIndex))
        
        if bundleIndex == 1 &&
            !authAPIModel.bundleImage.isEmpty{
            
            AsyncImage(url: URL(string: authAPIModel.bundleImage[bundleIndex - 1])) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
            }
            placeholder: {
                
                
                let decoded = try? PropertyListDecoder().decode(Data.self, from: imageData ?? Data())
                
                if decoded != nil {
                    let uiImage = UIImage(data: decoded!)

                    ZStack {
                        Image(uiImage: uiImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .blur(radius: 10)
                            .cornerRadius(10)
                        
                        ProgressView().tint(.gray)
                    }
                }
                
                
                
            }
            
        }
        else if authAPIModel.reloadBundleAnimation  {

            let decoded = try? PropertyListDecoder().decode(Data.self, from: imageData ?? Data() )
            
            if decoded != nil {
                let uiImage = UIImage(data: decoded!)
                
                ZStack {
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .blur(radius: 10)
                        .cornerRadius(10)
                    
                    ProgressView().tint(.gray)
                }
            }
            else {
                ProgressView().tint(.gray)
            }
            
            
        }
        else {
            
            let decoded = try? PropertyListDecoder().decode(Data.self, from: imageData ?? Data() )
            
            if decoded != nil {
                let uiImage = UIImage(data: decoded!)
                
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
        }
    }
}

