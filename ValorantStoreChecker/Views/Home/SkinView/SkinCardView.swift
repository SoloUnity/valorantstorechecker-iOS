//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    @EnvironmentObject private var skinModel : SkinModel
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @Environment(\.colorScheme) var colourScheme
    @AppStorage("dark") var toggleDark = false
    @AppStorage("autoDark") var auto = false
    @ObservedObject var skin:Skin
    @State var isDetailViewShowing = false
    
    var showPrice = false
    var showPriceTier = false
    var price = ""
    var originalPrice = false
    var percentOff = ""
    var nightPrice = false
    
    var body: some View {
        
        Button {
            // Dismiss keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
            isDetailViewShowing = true
        } label: {
            
            ZStack{
                
                
                
                if let imageData = UserDefaults.standard.data(forKey: skin.levels!.first!.id.description) {
                    
                    // MARK: Level Image
                    let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData )
                    
                    let uiImage = UIImage(data: decoded)
                    
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                }
                else {
                    
                    // MARK: Chroma Image
                    if let imageData = UserDefaults.standard.data(forKey: skin.chromas![0].id.description) {
                        
                        let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
                        
                        let uiImage = UIImage(data: decoded)
                        
                        Image(uiImage: uiImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        
                    }
                    else {
                        // MARK: Async Image
                        AsyncImage(url: URL(string: skin.levels!.first!.displayIcon!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .padding()
                        
                    }
                    
                    
                }
                
                
                VStack{
                    
                    
                    
                    Spacer()
                    
                    HStack{
                        
                        // MARK: Price Tier
                        if skin.contentTierUuid != nil && showPriceTier{
                            PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 18)
                        }
                        else{
                            Image(systemName: "questionmark.circle")
                                .frame(width:10, height: 10)
                                .shadow(color: .white, radius: 1)
                        }
                        
                        // MARK: Name
                        Text(skin.displayName)
                            .font(.subheadline)
                            .bold()
                            .shadow(color: .black, radius: 3)
                            .lineLimit(1)
                        
                        
                        Spacer()
                        
                    }
                }
                .padding(.leading)
                
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // MARK: Price
                        if showPrice {
                            

                            if price != "" && nightPrice {
                                
                                VStack {
                                    HStack{
                                        
                                        if skin.contentTierUuid != nil {
                                            let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                                            
                                            if price != "Unknown" {
                                                
                                                
                                                Text(price)
                                                    .strikethrough()
                                                    .font(.subheadline)
                                                    .bold()
                                                    .shadow(color: .black, radius: 3)
                                                    .opacity(0.3)
                                                
                                            }
                                        }
                                        
                                        Image("vp")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                            .shadow(color: .white, radius: 2)
                                        
                                        Text(price)
                                            .font(.subheadline)
                                            .bold()
                                            .shadow(color: .black, radius: 3)
                                        
                                    }
                                    
                                    // MARK: Percent off
                                    if percentOff != "" {
                                        Text("-" + percentOff + "%")
                                            .font(.subheadline)
                                            .bold()
                                            .shadow(color: .black, radius: 3)
                                            .opacity(0.3)
                                    }
                                    
                                    
                                
                                }
                                .padding(.horizontal, 20)
                                .background(.ultraThinMaterial, in: Rectangle())
                                .rotationEffect(Angle(degrees: -40))
                                .offset(x: 30)

                                
                                
                                
                                
                            }
                            else if price != "" {
                                HStack {
                                    if price != "Unknown" {
                                        
                                        Image("vp")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                            .shadow(color: .white, radius: 2)
                                        
                                        Text(self.price)
                                            .font(.subheadline)
                                            .bold()
                                            .shadow(color: .black, radius: 3)

                                    }
                                }
                                .padding(.trailing)
                            }
                            else if skin.contentTierUuid != nil {
                                let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                                
                                HStack {
                                    if price != "Unknown" {
                                        
                                        Image("vp")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                            .shadow(color: .white, radius: 2)
                                        
                                        Text(price)
                                            .font(.subheadline)
                                            .bold()
                                            .shadow(color: .black, radius: 3)

                                    }
                                }
                                .padding(.trailing)
                                
                            }
                        }
                    }
                }
                
            }
            .foregroundColor(auto ? (colourScheme == .light ? .black : .white) : (toggleDark ? .white : .black))
        }
        .sheet(isPresented: $isDetailViewShowing) {
            SkinCardDetailView(skin: skin, price: price)
        }
    }
    
    
}



