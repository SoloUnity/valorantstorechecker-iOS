//
//  LoginBoxView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-30.
//

import SwiftUI

struct LoginBoxView: View {
    
    enum Field: Hashable {
        case usernameField
        case passwordField
    }
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @State private var showPassword : Bool = false
    @FocusState private var focusedField: Field?
    
    var body: some View {
        
        // Wacky implementation to ensure smooth animations
        if authAPIModel.authenticationFailure {
            VStack{
                
                // MARK: Username Box
                ZStack {
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.white)
                        
                        TextField(LocalizedStringKey("Username") , text: $authAPIModel.inputUsername)
                            .keyboardType(.default)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .submitLabel(.continue)
                            .focused($focusedField, equals: .usernameField)
                            .onSubmit {
                                self.focusedField = .passwordField
                            }

                    }
                    .padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
                }
                
                // MARK: Password Box
                ZStack {
                    HStack {
                        
                        Image(systemName: "key")
                            .foregroundColor(.white)
                        
                        if showPassword {
                            TextField(LocalizedStringKey("Password"), text: $authAPIModel.inputPassword)
                                .keyboardType(.default)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .submitLabel(.done)
                                .focused($focusedField, equals: .passwordField)

                        }
                        else {
                            
                            SecureField(LocalizedStringKey("Password"), text: $authAPIModel.inputPassword)
                                .keyboardType(.default)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .submitLabel(.done)
                                .focused($focusedField, equals: .passwordField)
                            
                        }
                        
                        
                        Button {
                            
                            showPassword.toggle()
                            
                        } label: {
                            
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .foregroundColor(.white)
                                .opacity(0.5)
                            
                        }

                        
                    }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                }
                
            }
            .foregroundColor(.pink)

        }
        else {
            VStack{
                
                // MARK: Username Box
                ZStack {
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.white)
                        
                        TextField(LocalizedStringKey("Username") , text: $authAPIModel.inputUsername)
                            .keyboardType(.default)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .submitLabel(.continue)
                            .focused($focusedField, equals: .usernameField)
                            .onSubmit {
                                self.focusedField = .passwordField
                            }

                    }
                    .padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
                }
                
                // MARK: Password Box
                ZStack {
                    HStack {
                        
                        Image(systemName: "key")
                            .foregroundColor(.white)
                        
                        if showPassword {
                            TextField(LocalizedStringKey("Password"), text: $authAPIModel.inputPassword)
                                .keyboardType(.default)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .submitLabel(.done)
                                .focused($focusedField, equals: .passwordField)

                        }
                        else {
                            
                            SecureField(LocalizedStringKey("Password"), text: $authAPIModel.inputPassword)
                                .keyboardType(.default)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .submitLabel(.done)
                                .focused($focusedField, equals: .passwordField)
                            
                        }
                        
                        
                        Button {
                            
                            showPassword.toggle()
                            
                        } label: {
                            
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .foregroundColor(.white)
                                .opacity(0.5)
                            
                        }

                        
                    }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                }
                
            }
            .foregroundColor(.white)
        }
  
    }
}

struct LoginBoxView_Previews: PreviewProvider {
    static var previews: some View {
        LoginBoxView()
    }
}
