//
//  ChromaView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI
import QuickLook

struct ChromaView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @ObservedObject var skin:Skin
    @Binding var selectedChroma : Int
    @State var url: URL?
    
    var body: some View {
        
        HStack{
            Spacer()
            
            if let imageData = UserDefaults.standard.data(forKey: skin.chromas![selectedChroma].id.description) {
                
                let decoded = try? PropertyListDecoder().decode(Data.self, from: imageData)
                
                if decoded != nil {
                    let uiImage = UIImage(data: decoded!)
                    
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
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
        

    }
}

