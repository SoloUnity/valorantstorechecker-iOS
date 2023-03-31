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
    @AppStorage("selectedTab") var selectedTab: Tab = .bundle
    @State var hasScrolled = false
    @State var index = 1
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ScrollViewReader { (proxy: ScrollViewProxy) in
            
            ScrollView(showsIndicators: false) {
                
                scrollDetection
                    .id("top")
                
                // Number of available bundles
                let bundleCount = authAPIModel.bundleCount
                
                if authAPIModel.bundleSkins.isEmpty{
                    
                    // MARK: No bundle error
                    
                    VStack {
                        
                        ShopTopBarView(reloadType: "bundleReload", referenceDate: defaults.object(forKey: "bundleTimeLeft" + String(index)) as? Date ?? Date())
                        
                        
                        VStack {
                            Spacer()
                            HStack{
                                
                                Spacer()
                                
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(minWidth: 0, maxWidth: 100)
                                    
                                    Text( LocalizedStringKey("EmptyBundle"))
                                    
                                    Spacer()
                                }
                                .opacity(0.5)
                                
                                Spacer()
                                
                            }
                            Spacer()
                        }
                        
                        
                        ShopBottomBarView()
                        
                        
                        
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                }
                else{
                    
                    // MARK: Content
                    
                    LazyVStack() {
                        
                        ShopTopBarView(reloadType: "bundleReload", referenceDate: defaults.object(forKey: "bundleTimeLeft" + String(index)) as? Date ?? Date())
                        
                        Divider()
                            .padding(.leading)
                        
                        VStack {
                            BundleImageView(bundleIndex: index)
                            
                            
                            // MARK: Image information
                            HStack {
                                
                                Text(defaults.string(forKey: "bundleDisplayName" + String(index)) ?? "")
                                    .font(.subheadline)
                                    .bold()
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                // MARK: Price
                                if authAPIModel.bundlePrice != [] {
                                    if let price = authAPIModel.bundlePrice[index - 1] {
                                        
                                        Image("vp")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                        
                                        Text(String(price))
                                            .font(.subheadline)
                                            .bold()
                                        
                                        
                                        
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        
                        // Displays multiple bundles
                        if bundleCount != 1 {
                            Picker("Bundle Name", selection: $index){
                                ForEach(1...bundleCount, id: \.self){ item in
                                    
                                    Text(defaults.string(forKey: "bundleDisplayName" + String(item)) ?? "")
                                        .tag(item)
                                    
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                            .onChange(of: index) { _ in
                                authAPIModel.bundleImage = []
                            }
                        }
                        
                        Divider()
                            .padding(.leading)
                        
                        ForEach(authAPIModel.bundleSkins[index - 1]) { skin in
                            
                            HStack {
                                
                                TierBar(contentTierUuid: skin.contentTierUuid ?? "")
                                SkinCardView(skin: skin, showPrice: true, showPriceTier: true, price: skin.discountedCost ?? "")
                                    .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                            }
                            
                            
                            Divider()
                                .padding(.leading)
                            
                        }
                        
                        ShopBottomBarView()
                        
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))

                }
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .padding(.horizontal)
            .overlay {
                NavigationBar(title: "Bundle", hasScrolled: $hasScrolled)
            }
            .refreshable {
                
                withAnimation(.easeIn) {
                    authAPIModel.reloadBundleAnimation = true
                }
                
                Task{
                    await authAPIModel.reload(skinModel: skinModel, reloadType: "bundleReload")
                }
            }
            .onChange(of: selectedTab, perform: { tab in
                if tab == .bundle {
                    
                    self.hasScrolled = false
                    proxy.scrollTo("top", anchor: .top)
                    
                }
            })
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in

            Color.clear
                .preference(key: ScrollPreferenceKey.self,
                            value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                hasScrolled = value < 0
            }
        }
    }
}


