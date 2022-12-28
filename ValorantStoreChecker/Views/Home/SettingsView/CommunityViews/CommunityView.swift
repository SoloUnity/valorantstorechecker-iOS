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
                    SettingItemView(itemType: "generic", name: "Website and Discord Bot", iconBG: .green, iconColour: .white, image: "globe", showChevron: true, toggleBool: $dummy)
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
                    SettingItemView(itemType: "custom", name: "DiscordServer", iconBG: .purple, iconColour: .white, image: "discord", showChevron: true, toggleBool: $dummy)
                }
            }
            

             
        }
        .navigationTitle(LocalizedStringKey("Community"))
    }
}


