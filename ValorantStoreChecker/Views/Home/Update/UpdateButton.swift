//
//  UpdateButton.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-11.
//

import SwiftUI
import StoreKit

struct UpdateButton: View {
    
    @State var update = false
    
    var body: some View {
        
        Text(LocalizedStringKey("Update"))
            .foregroundColor(.pink)
            .font(.caption)
            .onTapGesture {
                
                self.update = true
            }
            .sheet(isPresented: $update, content: {
                UpdatesView()
            })
        /*
            .alert(LocalizedStringKey("UpdateTitle"), isPresented: $update, actions: {
                
                

                
                Button(LocalizedStringKey("OK"), role: nil, action: {
                     
                    self.update = false
                })
                
                Button(LocalizedStringKey("Update"), role: nil, action: {
                    
                    if let url = URL(string: "https://apps.apple.com/ca/app/store-checker-for-valorant/id1637273546") {
                        UIApplication.shared.open(url)
                    }
                    
                })
                
            }, message: {
                
                Text(LocalizedStringKey("UpdateInstructions"))
                
            })
         */

    }
    

    
}

struct UpdateButton_Previews: PreviewProvider {
    static var previews: some View {
        UpdateButton()
    }
}
