//
//  TitleView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct TitleView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @ObservedObject var skin:Skin
    
    @State private var isPresentingShareSheet = false
    
    var body: some View {
        // MARK: Title header
        HStack{
            
            if skin.contentTierUuid != nil{
                PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 30)
            }else{
                Image(systemName: "questionmark.circle")
                    .frame(width: 30, height: 30)
            }
            
            
            Text (String(skin.displayName))
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            
            Spacer()
            
            // MARK: Share Button
            if #available(iOS 16.0, *) {
                ShareLink(item: URL(string: "https://valorantstore.net/skin/\(skin.id.description.lowercased())")!) {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height:20)
                }
            }
            else {
                Button {
                    DispatchQueue.global(qos: .background).async {
                        self.isPresentingShareSheet = true
                    }
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height:20)
                }
                .shareSheet(isPresented: $isPresentingShareSheet, items: [URL(string: "https://valorantstore.net/skin/\(skin.id.description.lowercased())")!])
            }
            
            
        }
    }
}

