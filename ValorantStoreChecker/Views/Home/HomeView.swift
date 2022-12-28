//
//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @EnvironmentObject private var skinModel : SkinModel
    @AppStorage("nightMarket") var nightMarket : Bool = false
    @State private var tabIndex = 0
    
    private let defaults = UserDefaults.standard

    
    
    var body: some View {
        

        TabView(selection: $tabIndex) {
            ShopView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem {
                    Image(systemName: "cart")
                    Text(LocalizedStringKey("Store"))
                }
                .tag(0)
            
                
            if nightMarket {
                NightMarketView()
                    .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                    .tabItem{
                    Image(systemName: "moon.stars")
                    Text(LocalizedStringKey("NightMarket"))
                    }
                    .tag(4)
            }
            
            
            BundleView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                Image(systemName: "archivebox.fill")
                Text(LocalizedStringKey("Bundle"))
                }
                .tag(1)

            
            SkinListView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text(LocalizedStringKey("SkinIndex"))
                }
                .tag(2)
            
            SettingsView(referenceDate: defaults.object(forKey: "timeLeft") as? Date ?? Date())
                .tabItem {
                    Image(systemName: "gear")
                    Text(LocalizedStringKey("Settings"))
                }
                .tag(3)

            
        }
        //.accentColor(.white)
        //.foregroundColor(.white)
        //.tint(.white)
        //.preferredColorScheme(.dark)
        
        
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
