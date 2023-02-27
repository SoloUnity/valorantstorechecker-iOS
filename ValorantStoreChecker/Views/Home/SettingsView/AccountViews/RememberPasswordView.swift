//
//  RememberPasswordView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-23.
//

import SwiftUI
import Keychain

struct RememberPasswordView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @State var unhide = false           // Toggle showing / hiding password
    @Binding var togglePassword : Bool
    let defaults = UserDefaults.standard
    let keychain = Keychain()
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            SettingItemView(itemType: "generic", name: "RememberPassword", iconBG: .gray, iconColour: .white, image: "key.fill", toggleBool: $togglePassword)
                
            HStack {
                Spacer()
                
                Toggle("", isOn: $togglePassword)
                    .onChange(of: togglePassword) { boolean in
                        
                        if boolean {
                            
                            self.togglePassword = true
                        }
                        else {
                            defaults.removeObject(forKey: "rememberPassword")
                            authAPIModel.inputPassword = ""
                            let _ = keychain.remove(forKey: "password")
                        }
                        
                    }
            }
        }
        .animation(.easeInOut(duration: 0.15), value: togglePassword)
        .onChange(of: authAPIModel.inputPassword) { password in
            let _ = keychain.save(authAPIModel.inputPassword, forKey: "password")
        }
        .onAppear {
            
            if togglePassword {
                authAPIModel.inputPassword = keychain.value(forKey: "password") as? String ?? ""
            }
            
        }
        .onDisappear {
            authAPIModel.inputPassword = ""
        }
        
        if togglePassword {

            HStack {
                
                Spacer()
                
                if unhide {
                    TextField(LocalizedStringKey("Password"), text: $authAPIModel.inputPassword)

                }
                else {
                    SecureField(LocalizedStringKey("Password"), text: $authAPIModel.inputPassword)

                }
                
                Button {
                    self.unhide.toggle()
                } label: {
                    if unhide {
                        Image(systemName: "eye")
                            .opacity(0.5)
                    }
                    else {
                        Image(systemName: "eye.slash")
                            .opacity(0.5)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

