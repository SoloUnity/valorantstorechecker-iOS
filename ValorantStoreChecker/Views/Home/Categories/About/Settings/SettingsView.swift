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
    @State var togglePassword = false   // Password fallback
    @State var unhide = false           // Toggle showing / hiding password
    @State var toggleReload = false     // Toggle reload
    @State private var selectedDate = Date()
    @State var toggleNotification = false
    
    let notify = NotificationService()
    let defaults = UserDefaults.standard
    let keychain = Keychain()
    
    let referenceDate: Date
    
    var body: some View {
        

        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("Settings"))
                        .font(.title)
                        .bold()
                    
                    // MARK: Automatic Reloading
                    VStack {
                        VStack {
                            
                            Toggle(LocalizedStringKey("AutomaticReload"), isOn: $toggleReload)
                                .tint(.pink)
                                .onChange(of: toggleReload) { boolean in
                                    
                                    authAPIModel.autoReload = boolean
                                    
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
                        
                        Text(LocalizedStringKey("AutomaticReloadInfo"))
                            .font(.caption2)
                            .opacity(0.5)
                            .padding(.horizontal, 5)
                    }
                    
                    
                    // MARK: Language
                    VStack {
                        
                        HStack {
                            
                            Text(LocalizedStringKey("Language"))
                            
                            Spacer()
                            
                            Button {
                                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                                }
                                
                            } label: {
                                                                
                                Text(LocalizedStringKey("ChangeLanguage"))
                                    .font(.callout)
                                    .foregroundColor(.pink)
                                    
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
                    
                    Text(LocalizedStringKey("LanguageDescription"))
                        .font(.caption2)
                        .opacity(0.5)
                        .padding(.horizontal, 5)
                    
                    // MARK: Notifications
                    VStack {
                        
                        Toggle(LocalizedStringKey("Notify"), isOn: $toggleNotification)
                            .tint(.pink)
                            .onChange(of: toggleNotification) { boolean in
                                
                                defaults.set(boolean, forKey: "notification")
                                
                                notify.askPermission()
                                
                                if boolean {
                                    notify.sendNotification(date: referenceDate, title: "Store Checker for Valorant", body: "Store has just reset")

                                }
                                else {
                                    notify.disableNotifications()

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
                    
                    
                    Text(LocalizedStringKey("NotifyDescription"))
                        .font(.caption2)
                        .opacity(0.5)
                        .padding(.horizontal, 5)
                    
                    
                    
                    
                    
                    // MARK: Remember Password
                    VStack {
                        
                        Toggle(LocalizedStringKey("RememberPassword"), isOn: $togglePassword)
                            .tint(.pink)
                            .onChange(of: togglePassword) { boolean in
                                
                                
                                authAPIModel.rememberPassword = boolean
                                
                                if boolean {
                                    defaults.set(boolean, forKey: "rememberPassword")
                                    
                                }
                                else {
                                    defaults.removeObject(forKey: "rememberPassword")
                                    authAPIModel.password = ""
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
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Button {
                                            self.unhide.toggle()
                                        } label: {
                                            if unhide {
                                                Image(systemName: "eye")
                                                    .padding(.trailing)
                                                    .opacity(0.5)
                                            }
                                            else {
                                                Image(systemName: "eye.slash")
                                                    .padding(.trailing)
                                                    .opacity(0.5)
                                            }
                                        }
                                    }
                                        
                                }
                                .onChange(of: authAPIModel.password) { password in
                                    let _ = keychain.save(authAPIModel.password, forKey: "password")
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
                    
                    
                    
                    Text(LocalizedStringKey("RememberPasswordInfo"))
                        .font(.caption2)
                        .opacity(0.5)
                        .padding(.horizontal, 5)
                    
                }
                .padding()
                .onAppear {
                    
                    
                    if defaults.bool(forKey: "rememberPassword") {
                        self.togglePassword = true
                        
                        authAPIModel.password = keychain.value(forKey: "password") as? String ?? ""
                    }
                    
                    if defaults.bool(forKey: "autoReload") {
                        self.toggleReload = true
                    }
                    
                    if defaults.bool(forKey: "notification") {
                        self.toggleNotification = true
                    }
                }
                .onDisappear {
                    authAPIModel.password = ""
                }
            }
        }
        
        
        
    }
}

