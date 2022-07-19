//
//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var tabIndex = 0
    
    let gradient = Gradient(colors: [Color(red: 28/255, green: 28/255, blue: 30/255),Color(red: 28/255, green: 28/255, blue: 30/255), .pink])
    
    
    var body: some View {
        
        TabView(selection: $tabIndex) {
            ShopView()
                .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "cart")
                    Text("Store")
                }
                .tag(0)
                                
            SkinListView()
                .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("Skins Index")
                }
                .tag(1)
            
            WishListView()
                .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "heart.fill")
                    Text("Wish List")
                }
                .tag(2)
            
            SettingsView()
                .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
            
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
