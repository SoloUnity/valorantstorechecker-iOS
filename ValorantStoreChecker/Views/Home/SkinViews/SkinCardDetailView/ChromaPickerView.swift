//
//  ChromaPickerView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct ChromaPickerView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @ObservedObject var skin:Skin
    @Binding var selectedChroma : Int
    
        var body: some View {
        
        // Custom picker for images
        HStack(spacing: 0) {
            
            ForEach(0..<skin.chromas!.count, id:\.self) { index in
                let isSelected = selectedChroma == index
                
                // Uses stored swatch image
                if let imageData = UserDefaults.standard.data(forKey: skin.chromas![index].id.description + "swatch") {
                    
                    let decoded = try? PropertyListDecoder().decode(Data.self, from: imageData)
                    
                    if decoded != nil {
                        let uiImage = UIImage(data: decoded!)
                        
                        ZStack {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                            
                            Rectangle()
                                .fill(.white)
                                .opacity(isSelected ? 0.3 : 0.01)
                                .cornerRadius(10)
                                .padding(2)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.25,
                                                                     dampingFraction: 2,
                                                                     blendDuration: 0.25)) {
                                        self.selectedChroma = index
                                    }
                                }
                                .shadow(color: .gray, radius: 1)
                        }
                        .overlay(
                            
                            ZStack {
                                
                                Image(uiImage: uiImage ?? UIImage())
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .frame(width: 25, height: 25)
                                
                            }
                            
                            
                        )
                        .frame(height: 35)
                    }
                }
                
            }
        }
        .cornerRadius(10)
        .padding()

        
    }
}

