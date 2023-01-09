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
                    SettingItemView(itemType: "generic", name: "Create", iconBG: .mint, iconColour: .white, image: "envelope.fill", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                
                // Source Code
                
                Button {

                    if let url = URL(string: Constants.URL.sourceCode) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "SourceCode", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                
            }
            
            Section(header: Text("FAQ")) {
                
                Text("FAQText")
                
                
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
             
        }
        .navigationTitle(LocalizedStringKey("Support"))
    }
}

