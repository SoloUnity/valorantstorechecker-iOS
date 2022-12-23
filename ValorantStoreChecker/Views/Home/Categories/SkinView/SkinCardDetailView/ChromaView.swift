//
//  ChromaView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct ChromaView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @ObservedObject var skin:Skin
    @Binding var selectedChroma : Int
    
    var body: some View {
        HStack{
            Spacer()
            
            if let imageData = UserDefaults.standard.data(forKey: skin.chromas![selectedChroma].id.description) {
                
                let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
                
                let uiImage = UIImage(data: decoded)
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .padding()
                
            }
            else if skin.chromas![selectedChroma].displayIcon != nil{
                
                AsyncImage(url: URL(string: skin.chromas![selectedChroma].displayIcon!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .padding()
                
            }
            else if skin.chromas![selectedChroma].fullRender != nil{
                
                AsyncImage(url: URL(string: skin.chromas![selectedChroma].fullRender!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .padding()
                
            }
            
            Spacer()
        }
        .frame(height: (UIScreen.main.bounds.height / 5.5))
        .background(Blur(radius: 25, opaque: true))
        .cornerRadius(10)
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 3)
                .offset(y: -1)
                .offset(x: -1)
                .blendMode(.overlay)
                .blur(radius: 0)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                }
        }
    }
}

