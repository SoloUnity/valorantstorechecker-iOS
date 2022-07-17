//
//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct HomeView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            ShopView()
                .tabItem{
                    Image(systemName: "rectangle.grid.2x2")
                    Text("Shop")
                }
                .tag(0)
                                
            

            SettingsView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(1)
        }
        .accentColor(.white)
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
