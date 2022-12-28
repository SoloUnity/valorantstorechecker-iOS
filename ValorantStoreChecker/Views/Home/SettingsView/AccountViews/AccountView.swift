//
//  AccountView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI
import Keychain

struct AccountView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @AppStorage("rememberPassword") var togglePassword = false
    
    let keychain = Keychain()

    var body: some View {
        
        Form {
            
            
            Section(footer: Text(LocalizedStringKey("RememberPasswordInfo"))) {
                
                RememberPasswordView(togglePassword: $togglePassword)
   
            }
            
            
            Section(footer: Text("Switch Accounts is currently in development and does not work.")) {
                RegionView()
                
                AccountSwitcherView()
            }
            
            
            Section() {
                
                Button {
                    Task {
                        authAPIModel.logOut()
                    }
                } label: {
                    
                    HStack {
                        Spacer()
                        
                        Text("SignOut")
                            .foregroundColor(.pink)
                        
                        Spacer()
                    }
                    
                    
                }

            }
           
            
        }
        .navigationBarTitle(LocalizedStringKey("Account"))
        .animation(.default, value: togglePassword)
        
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
