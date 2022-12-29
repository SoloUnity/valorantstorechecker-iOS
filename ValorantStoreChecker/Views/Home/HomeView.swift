//
//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-12-16.
//  https://www.youtube.com/watch?v=3psB2i2Ondo

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var model: Model
    @AppStorage("selectedTab") var selectedTab: Tab = .shop
    @AppStorage("showModal") var showModal = false
    @State var currentView = "shop"
    let diffBottomInset: CGFloat = 88
    
    var body: some View  {
        ZStack(alignment: .bottom) {

            
            // Done this way to preserve scroll state
            ShopView()
                .opacity(currentView == "shop" ? 1 : 0)
            
            BundleView()
                .opacity(currentView == "bundle" ? 1 : 0)
            
            SkinListView()
                .opacity(currentView == "skinList" ? 1 : 0)
            
            SettingsView()
                .opacity(currentView == "settings" ? 1 : 0)
            
            NightMarketView()
                .opacity(currentView == "nightMarket" ? 1 : 0)
            
            
            TabBar(diffSafeAreaBottomInset: diffBottomInset)
                .offset(y: model.showDetail ? 200 : 0)
            

        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: diffBottomInset)
        }
        .dynamicTypeSize(.large ... .xxLarge)
        .onAppear {
            switch selectedTab {
            case .shop:
                self.currentView = "shop"
            case .bundle:
                self.currentView = "bundle"
            case .skinList:
                self.currentView = "skinList"
            case .settings:
                self.currentView = "settings"
            case .nightMarket:
                self.currentView = "nightMarket"
            }
        }
        .onChange(of: selectedTab) { newValue in
            switch selectedTab {
            case .shop:
                self.currentView = "shop"
            case .bundle:
                self.currentView = "bundle"
            case .skinList:
                self.currentView = "skinList"
            case .settings:
                self.currentView = "settings"
            case .nightMarket:
                self.currentView = "nightMarket"
            }
        }
    }
}


