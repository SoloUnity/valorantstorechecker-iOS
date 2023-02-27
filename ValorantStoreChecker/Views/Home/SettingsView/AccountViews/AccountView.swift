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
            
            
            Section() {
                RegionView()
                
                //AccountSwitcherView()
            }
            
            Section() {
                
                Button {
                    
                    haptic()
                    
                    if let url = URL(string: Constants.URL.deleteAccount) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    
                    HStack {
                        Spacer()
                        
                        Text("DeleteAccount")
                            .foregroundColor(.pink)
                        
                        Spacer()
                    }
                    
                    
                }

            }
            
            Section() {
                
                Button {
                    
                    haptic()
                    
                    Task {
                        await authAPIModel.logOut()
                        
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
            
            
            
            Section(header: Text("")) {
                EmptyView()
                
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
