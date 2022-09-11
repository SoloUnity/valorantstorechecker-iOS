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
            
            if let imageData = UserDefaults.standard.data(forKey: "bundleDisplayIcon" + String(bundleIndex)) {
                
                let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData )
                
                let uiImage = UIImage(data: decoded)
                
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 60/255, green: 60/255, blue: 60/255), lineWidth: 3)
                            .offset(y: -1)
                            .offset(x: -1)
                            .mask {
                                RoundedRectangle(cornerRadius: 10)
                            }
                    }
                    .cornerRadius(10)
            }
            /*
            else {
                // Quicker load time but a data muncher
                AsyncImage(url: URL(string: authAPIModel.bundleImage)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 60/255, green: 60/255, blue: 60/255), lineWidth: 3)
                        .offset(y: -1)
                        .offset(x: -1)
                        .blendMode(.overlay)
                        .blur(radius: 0)
                        .mask {
                            RoundedRectangle(cornerRadius: 10)
                        }
                }

            }
            */
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Text(defaults.string(forKey: "bundleDisplayName" + String(bundleIndex)) ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .bold()
                        .shadow(color: .black, radius: 3)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    // Not working as of now
                    /*
                    if let price = defaults.string(forKey: "bundlePrice" + String(bundleIndex)) {
                        
                        if price != "" {
                            Image("vp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .shadow(color: .white, radius: 2)
                            
                            Text(price)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .bold()
                                .shadow(color: .black, radius: 3)
                        }
                    }
                    */
                }
                .padding(10)
            }
        }
        
    }
}

