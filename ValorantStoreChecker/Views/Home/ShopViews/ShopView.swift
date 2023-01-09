//
//  ShopView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI
//import GoogleMobileAds

struct ShopView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    @AppStorage("selectedTab") var selectedTab: Tab = .shop
    @State var hasScrolled = false
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        
        ScrollViewReader { (proxy: ScrollViewProxy) in
            ScrollView(showsIndicators: false) {
                
                scrollDetection
                    .id("top")
                
                
                LazyVStack() {
                    
                    // Determine if the data has been fetched
                    if authAPIModel.storefront.isEmpty{
                        
                        ShopTopBarView(reloadType: "storeReload", referenceDate: Date())
                        
                        
                        HStack{
                            
                            Spacer()
                            
                            ProgressView()
                            
                            Spacer()
                            
                        }
                        
                    }
                    else{
                        
                        let timeLeft = defaults.object(forKey: "timeLeft") as? Date ?? Date()
                        
                        // MARK: Displayed elements
                        ShopTopBarView(reloadType: "storeReload", referenceDate: timeLeft)
                        
                        Divider()
                            .padding(.leading)
                        
                        ForEach(authAPIModel.storefront) { skin in
                            
                            HStack {
                                TierBar(contentTierUuid: skin.contentTierUuid ?? "")
                                
                                SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                    .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                            }
                            
                            Divider()
                                .padding(.leading)
                        }
                        
                        
                        ShopBottomBarView()

                    }
                    
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .padding(.horizontal)
            .overlay {
                NavigationBar(title: "Store", hasScrolled: $hasScrolled)
            }
            .refreshable {
                
                withAnimation(.easeIn) {
                    authAPIModel.reloadAnimation = true
                }
                
                Task{
                    await authAPIModel.reload(skinModel: skinModel, reloadType: "storeReload")
                }
            }
            .onChange(of: selectedTab, perform: { tab in
                if tab == .shop {
                    
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
                self.hasScrolled = value < 0
            }
        }
    }
    
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .previewInterfaceOrientation(.portrait)
    }
}
