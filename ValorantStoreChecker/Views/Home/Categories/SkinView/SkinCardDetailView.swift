//
//  WeaponCardDetailView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import SwiftUI

//import GoogleMobileAds



struct SkinCardDetailView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @ObservedObject var skin:Skin
    
    @State var selectedLevel = 0
    @State var selectedChroma = 0
    @State var price = ""
    
    
    var body: some View {
        
        GeometryReader{ geo in
            
            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 40) {
                
                TitleView(skin: skin)
                
                VStack {
                    
                    // MARK: Price
                    PriceView(skin: skin, price: price)
                    
                    // MARK: Videos
                    if skin.levels!.count != 1 {
                        VideoView(skin: skin, selectedLevel: $selectedLevel)
                        
                        VideoPickerView(skin: skin, selectedLevel: $selectedLevel)
                    }
                    
                    ChromaView(skin: skin, selectedChroma: $selectedChroma)
                    
                    if skin.chromas!.count != 1{
                        
                        ChromaPickerView(skin: skin, selectedChroma: $selectedChroma)
                        
                    }
                }
            }
            .foregroundColor(.white)
            .padding()
        }
        .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
        .onAppear{
            self.selectedLevel = getCorrectIndex(skin: skin)
        }
        
    }
}



func getCorrectIndex(skin: Skin) -> Int {
    
    var index: Int = 0
    
    for level in skin.levels! {
        
        if level.streamedVideo != nil {
            return index
        }
        
        index += 1
    }
    
    return 0
    
}

