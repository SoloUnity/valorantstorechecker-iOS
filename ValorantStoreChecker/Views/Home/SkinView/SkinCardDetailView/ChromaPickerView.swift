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
                    
                    let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
                    
                    let uiImage = UIImage(data: decoded)
                    
                    ZStack {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                        
                        Rectangle()
                            .opacity(isSelected ? 1 : 0.01)
                            .foregroundColor(Color(red: 120/255, green: 120/255, blue: 120/255))
                            .cornerRadius(10)
                            .padding(2)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.2,
                                                                 dampingFraction: 2,
                                                                 blendDuration: 0.5)) {
                                    self.selectedChroma = index
                                }
                            }
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
                else if skin.chromas![selectedChroma].swatch != nil{
                    // Uses async image
                    ZStack {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                        
                        Rectangle()
                            .opacity(isSelected ? 1 : 0.01)
                            .foregroundColor(Color(red: 120/255, green: 120/255, blue: 120/255))
                            .cornerRadius(10)
                            .padding(2)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.2,
                                                                 dampingFraction: 2,
                                                                 blendDuration: 0.5)) {
                                    self.selectedChroma = index
                                }
                            }
                    }
                    .overlay(
                        
                        ZStack {
                            
                            AsyncImage(url: URL(string: skin.chromas![index].swatch!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: 25, height: 25)
                            
                            
                        }
                        
                        
                    )
                    .frame(height: 35)
                    
                    
                }
                
            }
        }
        .cornerRadius(10)
        .padding()

        
    }
}

