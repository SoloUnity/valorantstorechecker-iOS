//
//  DropDownView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-27.
//

import SwiftUI
import Keychain

struct RegionSelectorView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @State private var expand = false
    @State private var title = LocalizedStringKey("SelectRegion")
    private let keychain = Keychain()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Button {
                
                // Dismiss keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
                expand.toggle()
                
            } label: {
                
                HStack{
                    Text(title)
                        .padding(.bottom, 4)
                    
                    if expand {
                        
                        Spacer()
                        
                    }
                    
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .multilineTextAlignment(.trailing)
                }
                
            }
            
            if expand {
                
                if title != LocalizedStringKey("NorthAmerica") {
                    Button {
                        authAPIModel.regionCheck = true
                        let  _ = keychain.save("na", forKey: "region")

                        title = LocalizedStringKey("NorthAmerica")
                        expand = false
                        
                    } label: {
                        Text(LocalizedStringKey("NorthAmerica"))
                    }
                }
                
                
                if title != LocalizedStringKey("Europe") {
                    Button {
                        authAPIModel.regionCheck = true
                        let  _ = keychain.save("eu", forKey: "region")

                        title = LocalizedStringKey("Europe")
                        expand = false
                    } label: {
                        Text(LocalizedStringKey("Europe"))
                    }
                }
                
                
                if title != LocalizedStringKey("AsiaPacific") {
                    Button {
                        authAPIModel.regionCheck = true
                        let  _ = keychain.save("ap", forKey: "region")
                        
                        title = LocalizedStringKey("AsiaPacific")
                        expand = false
                    } label: {
                        Text(LocalizedStringKey("AsiaPacific"))
                    }
                }
                
                
                if title != LocalizedStringKey("SouthKorea") {
                    Button {
                        authAPIModel.regionCheck = true
                        let  _ = keychain.save("kr", forKey: "region")
                        
                        title = LocalizedStringKey("SouthKorea")
                        expand = false
                    } label: {
                        Text(LocalizedStringKey("SouthKorea"))
                    }
                }
            }
        }
        .foregroundColor(.white)
        .padding(7)
        .background(Color.pink)
        .cornerRadius(10)
        .animation(.spring(), value: expand)
        .shadow(color:.pink, radius: 2)
        .frame(maxWidth: 200)
    }
}

struct RegionSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSelectorView()
    }
}
