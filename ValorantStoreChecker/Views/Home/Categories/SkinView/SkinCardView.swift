//
//  WeaponCardView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SkinCardView: View {
    
    @EnvironmentObject var skinModel : SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @ObservedObject var skin:Skin
    @State private var isDetailViewShowing = false
    
    var showPrice = false
    var showPriceTier = false
    var price = ""
    var originalPrice = false
    var percentOff = false
    
    var body: some View {
        
        Button {
            // Dismiss keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
            isDetailViewShowing = true
        } label: {
            
            ZStack{
                
                // MARK: Image
                
                
                if let imageData = UserDefaults.standard.data(forKey: skin.levels!.first!.id.description) {
                    
                    let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData )
                    
                    let uiImage = UIImage(data: decoded)
                    
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                } else {
                    // Quicker load time but a data muncher
                    AsyncImage(url: URL(string: skin.levels!.first!.displayIcon!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .padding()
                    
                }
                
                
                VStack{
                    HStack{
                        let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                        
                        
                        
                        
                        Spacer()
                        
                        if originalPrice {
    
                            HStack {
                                if price != "Unknown" {
                                    
                                    Image("vp")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                        .shadow(color: .white, radius: 2)
                                        .opacity(0.3)
                                    
                                    Text(price)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .bold()
                                        .shadow(color: .black, radius: 3)
                                        .opacity(0.3)
                                        
                                }
                            }     
                        }
                        
                        if percentOff && self.price != ""{
                            Text("-" + percentCalculator(originalPrice: price, discountPrice: self.price) + "%")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .bold()
                                .shadow(color: .black, radius: 3)
                                .opacity(0.3)
                        }
                        
                    }
                    .padding(10)
                    
                    Spacer()
                    
                    HStack{
                        
                        // MARK: Price Tier
                        if skin.contentTierUuid != nil && showPriceTier{
                            PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 18)
                        }
                        else{
                            Image(systemName: "questionmark.circle")
                                .frame(width:10, height: 10)
                                .foregroundColor(.white)
                                .shadow(color: .white, radius: 1)
                        }
                        
                        // MARK: Name
                        let name = skin.displayName
                            
                        if name.count > 27 {
                            
                            Text(cleanName(name: name))
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .bold()
                                .shadow(color: .black, radius: 3)
                                .lineLimit(1)
                            
                        }
                        else {
                            
                            Text(String(skin.displayName))
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .bold()
                                .shadow(color: .black, radius: 3)
                                .lineLimit(1)
                            
                        }
                        
                        
                        Spacer()
                        
                        // MARK: Price
                        if showPrice{
                            
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
                            else if skin.contentTierUuid != nil {
                                let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                                
                                if price != "Unknown" {
                                    
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
                            
                        }
                        
                    }
                    .padding(10)
                }
            }
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
        .sheet(isPresented: $isDetailViewShowing) {
            SkinCardDetailView(skin: skin, price: price)
                .preferredColorScheme(.dark)
        }
    }
    
    
}

func cleanName(name: String) -> String {
    let nameList = name.split(separator: " ")
    
    var finalName = ""
    for word in nameList {
        if finalName.count != 0 {
            finalName += " "
        }
        
        let tempName = finalName + word
        if tempName.count > 27 {
            return finalName
        }
        
        finalName += word
    }
    return finalName
}

func percentCalculator(originalPrice: String, discountPrice: String) -> String {
    if originalPrice != "Unknown" {
        
        let thing1 = (Float(discountPrice) ?? 1)/(Float(originalPrice) ?? 1)
        let thing2 = ((1 - thing1) * 100).rounded()
        let thing3 = Int(thing2)
        return String(thing3)
    }
    
    return "Unknown"
}
