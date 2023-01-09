//
//  AcknowledgementsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct AcknowledgementsView: View {
    
    @State var dummy : Bool = false
    
    var body: some View {
        
        Form {
            Section() {
                
                HStack {
                    Spacer()
                    
                    Image("lunacImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .border(.gray)
                        .clipShape(Circle())
                        
                        

                    
                    Spacer()
                }
                
                Text(LocalizedStringKey("ThankLunac"))
                
                Button {

                    if let url = URL(string: Constants.URL.lunac) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    
                    
                    
                    SettingItemView(itemType: "generic", name: "Lunac", iconBG: .green, iconColour: .white, image: "globe", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                
            }
            
            Section() {
                
                HStack {
                    Spacer()
                    
                    Image("julianImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Spacer()
                }
                
                
                Text(LocalizedStringKey("ThankJulian"))
                
                Button {

                    if let url = URL(string: Constants.URL.julian) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    
                    
                    
                    SettingItemView(itemType: "custom", name: "Julian", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
            
        }
        .navigationTitle(LocalizedStringKey("Acknowledgements"))

    }
}



