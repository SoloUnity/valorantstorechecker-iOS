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
        TabView(selection: $tabIndex) {        // $ is a 2 way binding, where TabView is notified on change of TabIndex and tapped buttons notify/change tabIndex value
            ShopView()                                   // What’s shown in the first tab
                .tabItem{                                    // What displays on the tab in the bottom
                    Image(systemName: "rectangle.grid.2x2")
                        .accentColor(.white)
                    Text("Shop")
                }
                .tag(0)                                    // Sets @State tabIndex  value

            SettingsView()                                        // What’s shown in the second tab
                .tabItem{
                    Image(systemName: "gear")
                        .accentColor(.white)
                    Text("Settings")
                }
                .tag(1)
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
