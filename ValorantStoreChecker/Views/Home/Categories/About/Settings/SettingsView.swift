//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-11.
//

import SwiftUI
import Keychain

struct SettingsView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @State var togglePassword = false
    @State var showPassword = false
    @State var unhide = false
    @State var toggleReload = false
    
    let defaults = UserDefaults.standard
    let keychain = Keychain()
    
    var body: some View {
        

        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("Settings"))
                        .font(.title)
                        .bold()
                    
                    VStack {
                        
                        Toggle("Remember password", isOn: $toggleReload)
                            .tint(.pink)
                            .onChange(of: toggleReload) { boolean in
                                
                                
                                
                                authAPIModel.rememberPassword = boolean
                                
                                if boolean {
                                    defaults.set(boolean, forKey: "autoReload")

                                }
                                else {
                                    defaults.removeObject(forKey: "autoReload")
                                }
                                
                            }
                        
                        
                        
                            
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Blur(radius: 25, opaque: true))
                    .cornerRadius(10)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 3)
                            .offset(y: -1)
                            .offset(x: -1)
                            .blendMode(.overlay)
                            .blur(radius: 0)
                            .mask {
                                RoundedRectangle(cornerRadius: 10)
                            }
                    }
                    
                    // Password toggle
                    VStack {
                        
                        Toggle("Remember password", isOn: $togglePassword)
                            .tint(.pink)
                            .onChange(of: togglePassword) { boolean in
                                
                                
                                
                                authAPIModel.rememberPassword = boolean
                                
                                if boolean {
                                    defaults.set(boolean, forKey: "rememberPassword")

                                }
                                else {
                                    defaults.removeObject(forKey: "rememberPassword")
                                    let _ = keychain.remove(forKey: "password")
                                }
                                
                            }
                        
                        
                        if togglePassword {
                            
                            
                            HStack {
                                ZStack {
                                    if unhide {
                                        TextField(LocalizedStringKey("Password"), text: $authAPIModel.password)
                                            .padding(.horizontal)
                                    }
                                    else {
                                        SecureField(LocalizedStringKey("Password"), text: $authAPIModel.password)
                                            .padding(.horizontal)
                                    }
                                    
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .opacity(0.5)
                                        
                                }
                                .onChange(of: authAPIModel.password) { password in
                                    let _ = keychain.save(authAPIModel.password, forKey: "password")
                                }
                                
                                Button {
                                    self.unhide.toggle()
                                } label: {
                                    if unhide {
                                        Image(systemName: "eye.slash.fill")
                                        
                                    }
                                    else {
                                        Image(systemName: "eye")
                                    }
                                }

                            }
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            
                            
                        }
                        
                            
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Blur(radius: 25, opaque: true))
                    .cornerRadius(10)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 3)
                            .offset(y: -1)
                            .offset(x: -1)
                            .blendMode(.overlay)
                            .blur(radius: 0)
                            .mask {
                                RoundedRectangle(cornerRadius: 10)
                            }
                    }
                    .onAppear {
                        if defaults.bool(forKey: "rememberPassword") {
                            self.togglePassword = true
                            
                            authAPIModel.password = keychain.value(forKey: "password") as? String ?? ""
                        }
                    }
                    .onDisappear {
                        authAPIModel.password = ""
                    }
                    
                    
                    Text("Your password is secured by keychain. Signing out or disabling the toggle will automatically forget the password. Enabling this feature bypasses the API limitations and allows for automatic sign in on the user's behalf.")
                        .font(.caption2)
                        .opacity(0.5)
                        .padding(.horizontal, 5)
                    
                }
                .padding()
            }
        }
        
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
