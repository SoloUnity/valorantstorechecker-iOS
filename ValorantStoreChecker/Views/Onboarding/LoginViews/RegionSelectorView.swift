//
//  DropDownView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-27.
//

import SwiftUI
import Keychain

struct RegionSelectorView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @State private var title = LocalizedStringKey("SelectRegion")
    @Binding var regionCheck : Bool
    
    private let keychain = Keychain()
    
    var body: some View {
        
        HStack{
            
            Text(LocalizedStringKey("SelectRegion"))
                .foregroundColor(.white)
                .bold()
            
            Spacer()
            
            Menu {
                
                Button {
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    self.title = LocalizedStringKey("Americas")
                    let  _ = keychain.save("na", forKey: "region")
                    
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.regionCheck = true
                    }
                   
                    
                } label: {
                    Text(LocalizedStringKey("Americas"))
                }
                
                Button {
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    self.title = LocalizedStringKey("Europe")
                    let  _ = keychain.save("eu", forKey: "region")
                    
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.regionCheck = true
                    }
                    
                } label: {
                    Text(LocalizedStringKey("Europe"))
                }
                
                Button {
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    self.title = LocalizedStringKey("AsiaPacific")
                    let  _ = keychain.save("ap", forKey: "region")
                    
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.regionCheck = true
                    }
                    
                } label: {
                    Text(LocalizedStringKey("AsiaPacific"))
                }
                
                Button {
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    self.title = LocalizedStringKey("SouthKorea")
                    let  _ = keychain.save("kr", forKey: "region")
                    
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.regionCheck = true
                    }
                    
                } label: {
                    Text(LocalizedStringKey("SouthKorea"))
                }

                
            } label : {
                
                HStack {
                    Text(title)
                    Image(systemName: "chevron.up.chevron.down")
                }
            }
        }
    }
}

