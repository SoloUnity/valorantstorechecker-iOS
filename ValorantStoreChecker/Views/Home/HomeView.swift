//
//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var skinModel : SkinModel
    @State var tabIndex = 0

    var body: some View {
        
        TabView(selection: $tabIndex) {
            ShopView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "cart")
                    Text("Store")
                }
                .tag(0)
                                
            SkinListView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("Skin Index")
                }
                .tag(1)
            
            /*
            WishListView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "heart.fill")
                    Text("Wish List")
                }
                .tag(2)
             */
            
            AboutView()
                .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
                .tabItem{
                    Image(systemName: "person.circle")
                    Text("Account")
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
