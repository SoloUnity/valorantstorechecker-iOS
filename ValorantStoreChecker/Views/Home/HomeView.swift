//
//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-12-16.
//  https://www.youtube.com/watch?v=3psB2i2Ondo

import SwiftUI

struct HomeView: View {

    @AppStorage("selectedTab") var selectedTab: Tab = .shop
    let diffBottomInset: CGFloat = 88
    
    var body: some View  {

        ZStack(alignment: .bottom) {
            

            
            // Done this way to preserve scroll state
            ShopView()
                .opacity(selectedTab == .shop ? 1 : 0)
            
            BundleView()
                .opacity(selectedTab == .bundle ? 1 : 0)
            
            SkinListView()
                .opacity(selectedTab == .skinList ? 1 : 0)
            
            SettingsView()
                .opacity(selectedTab == .settings ? 1 : 0)
            
            NightMarketView()
                .opacity(selectedTab == .nightMarket ? 1 : 0)
            
            
            TabBar(diffSafeAreaBottomInset: diffBottomInset)

        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: diffBottomInset)
        }
        .dynamicTypeSize(.large ... .xxLarge)
        
    }
}


