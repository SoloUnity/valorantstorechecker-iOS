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
    
    var body: some View {
        ZStack{
            
            
            
            if let imageData = UserDefaults.standard.data(forKey: "bundleDisplayIcon") {
                
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

                
            } else {
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
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Text(defaults.string(forKey: "bundleDisplayName") ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .bold()
                        .shadow(color: .black, radius: 3)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(10)
            }
        }
        .cornerRadius(10)
    }
}

struct BundleImageView_Previews: PreviewProvider {
    static var previews: some View {
        BundleImageView()
    }
}
