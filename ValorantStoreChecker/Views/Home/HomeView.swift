//
//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct HomeView: View {
    
    
    
    @State var tabIndex = 0
    let gradient = Gradient(colors: [Color(red: 20/255, green: 20/255, blue: 20/255),Color(red: 20/255, green: 20/255, blue: 20/255), .pink])
    
    var body: some View {
        
        TabView(selection: $tabIndex) {
            ShopView()
                .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "rectangle.grid.1x2.fill")
                    Text("Shop")
                }
                .tag(0)
                                

            SettingsView()
                .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
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
