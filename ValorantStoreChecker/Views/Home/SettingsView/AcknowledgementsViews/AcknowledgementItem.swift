//
//  AcknowledgementItem.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2023-01-11.
//

import SwiftUI

struct AcknowledgementItem: View {
    
    @State var dummy : Bool = false
    var image : String;
    var name : String;
    var message : String;
    var iconType : String;
    var url : String;
    
    var body: some View {
        Section() {
            
            HStack {
                Spacer()
                
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .shadow(color: .gray, radius: 1)
                    .clipShape(Circle())
                    
                    

                
                Spacer()
            }
            
            Text(LocalizedStringKey(message))
            
            Button {

                if let url = URL(string: url) {
                    UIApplication.shared.open(url)
                }
                
            } label: {
                
                if iconType == "globe" {
                    SettingItemView(itemType: "generic", name: name, iconBG: .green, iconColour: .white, image: "globe", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                else {
                    SettingItemView(itemType: "custom", name: name, iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
            }
        }
    }
}


