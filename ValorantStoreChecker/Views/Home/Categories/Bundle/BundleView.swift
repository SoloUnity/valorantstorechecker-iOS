//
//  SpecialView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-18.
//

import SwiftUI

struct BundleView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    @State var index = 1
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            
            
            GeometryReader{ geo in
                VStack(spacing: 0){
                    
                    ScrollViewReader{ (proxy: ScrollViewProxy) in
                        
                        Logo()
                            .frame(width: geo.size.width/Constants.dimensions.logoSize)
                        
                        // Number of available bundles
                        let bundleCount = authAPIModel.bundleCount
                        
                        
                        ScrollView(showsIndicators: false) {
                            
                            
                            if authAPIModel.bundle.isEmpty{
                                
                                VStack {
                                    
                                    ShopTopBarView(reloadType: "bundleReload", referenceDate: defaults.object(forKey: "bundleTimeLeft" + String(index)) as? Date ?? Date())
                                    
                                    VStack {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(minWidth: 0, maxWidth: 100)
                                            .foregroundColor(.white)
                                        
                                        Text( LocalizedStringKey("EmptyBundle"))
                                    }
                                    .padding(.top, (UIScreen.main.bounds.height / 4))
                                    .opacity(0.5)
                                    
                                }
                                
                                
                                
                                
                            }
                            else{
                                
                                
                                LazyVStack(spacing: 11) {
                                    
                                    ShopTopBarView(reloadType: "bundleReload", referenceDate: defaults.object(forKey: "bundleTimeLeft" + String(index)) as? Date ?? Date())
                                    
                                    BundleImageView(bundleIndex: index)
                                    
                                    // Displays multiple bundles
                                    if bundleCount != 1 {
                                        Picker("Bundle Name", selection: $index){
                                            ForEach(1...bundleCount, id: \.self){ item in
                                                
                                                Text(defaults.string(forKey: "bundleDisplayName" + String(item)) ?? "")
                                                    .tag(item)
                                                
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                                        .accentColor(.red)
                                    }
                                    
                                    ForEach(authAPIModel.bundle[index - 1]) { skin in
                                        
                                        SkinCardView(skin: skin, showPrice: true, showPriceTier: true, price: skin.discountedCost ?? "")
                                            .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                        
                                    }
                                    
                                    
                                    if authAPIModel.bundle[index - 1].count > 3 {
                                        GoUpButton(proxy: proxy)
                                    }
                                    
                                    
                                }
                                .id("top") // Id to identify the top for scrolling
                            }
                            
                            //AdPaddingView()
                        }
                        .padding(.top, -8)
                        .refreshable {
                            
                            withAnimation(.easeIn(duration: 0.2)) {
                                authAPIModel.reloading = true
                            }
                            
                            Task{
                                await authAPIModel.reload(skinModel: skinModel, reloadType: "bundleReload")
                            }
                        }
                        
                        
                        
                    }
                }
                
                
            }
            .padding(.bottom, 1)
            .padding(.horizontal)
            
            
        }
        
        
        
    }
}


