//
//  CommunityView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct CommunityView: View {
    
    @State var dummy : Bool = false
    
    var body: some View {
        
        Form {
            Section() {
                
                // Website
                Image("websiteImage")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(20)
                
                Button {

                    if let url = URL(string: Constants.URL.website) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    
                    // LOCALIZETEXT
                    SettingItemView(itemType: "generic", name: "WebAndDisc", iconBG: .green, iconColour: .white, image: "globe", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                
                
                
            }
            
            Section() {
                // Discord Server
                
                Image("discordImage")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(20)
                
                Button {

                    if let url = URL(string: Constants.URL.discord) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "DiscordServer", iconBG: .purple, iconColour: .white, image: "discord", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }

             
        }
        .navigationTitle(LocalizedStringKey("Community"))
    }
}


