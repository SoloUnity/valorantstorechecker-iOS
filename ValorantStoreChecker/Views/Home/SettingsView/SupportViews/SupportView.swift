//
//  SupportView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct SupportView: View {
    
    @State var dummy = false

    
    var body: some View {
        
        Form {
            Section() {
                // Ticket
                Button {

                    if let url = URL(string: Constants.URL.supportTicket) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "generic", name: "Create", iconBG: .mint, iconColour: .white, image: "envelope.fill", showChevron: true, toggleBool: $dummy)
                }
                
                // Source Code
                
                Button {

                    if let url = URL(string: Constants.URL.sourceCode) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "SourceCode", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, toggleBool: $dummy)
                }
                
            }
            
            Section(header: Text("FAQ")) {
                
                VStack {

                    Text("""
                        Why does the app need my login information?

                        While many of your statistics are free to access without your password, your store is a notable exception as it is considered sensitive information. In order for the app to access your store, it needs your login information where it obtains your store through this [open source API](https://github.com/HeyM1ke/ValorantClientAPI).

                        What are the measures in place to protect me?

                        In addition to never storing your password, sensitive information including your region is secured behind Keychain. The app is also open source, allowing anybody and everyone to access the code at all times. Your privacy is a priority, and I have done everything in my power to ensure it. For legal mumbo jumbo, see [here](https://www.craft.do/s/fQxdg6aSyp8WAk).

                        What assets are downloaded?

                        The assets downloaded are images which allow you to use the app's Skin index feature at all times, even when offline.

                        What does remember password do?

                        The current way that the reload button requires cookies instead of your username and password, allowing the app to not store your password at all. However, these cookies expire after a certain period, requiring the user to sign in again. In order to streamline this process, remember password allows the user to save their password and allow for automatic behind the scenes sign in. If the user wishes to not save the password, they can simply sign out and sign back in to create new cookies.
                        """)
                }
                
                
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
             
        }
        .navigationTitle(LocalizedStringKey("Support"))
    }
}

