//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @EnvironmentObject private var skinModel : SkinModel
    @State private var agreedToTerms: Bool = false
    @State private var showTerms : Bool = false
    @State private var showAlert : Bool = false
    
    var body: some View {
        
        
        GeometryReader { geo in
            
            ZStack(alignment: .top) {
                
                VStack(spacing: 15) {

                    Logo()
                        .frame(width: UIScreen.main.bounds.width/Constants.dimensions.logoSize, height: UIScreen.main.bounds.height/Constants.dimensions.logoSize)
                    
                    
                    // MARK: General Info
                    if !authAPIModel.failedLogin {
                        HStack {
                            Text(LocalizedStringKey("Login"))
                                .bold()
                            Button {
                                self.showAlert = true
                            } label: {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.pink)
                            }
                            
                            .alert(LocalizedStringKey("InformationTitle"), isPresented: $showAlert, actions: {
                                
                                Button(LocalizedStringKey("OpenLink"), role: nil, action: {
                                    
                                    if let url = URL(string: Constants.URL.sourceCode) {
                                        UIApplication.shared.open(url)
                                    }
                                    
                                })
                                
                                Button(LocalizedStringKey("OK"), role: nil, action: {})
                                
                            }, message: {
                                let info = LocalizedStringKey("Information")
                                Text(info)
                            })
                            
                        }
                        
                    }else {
                        HStack {
                            
                            Text(LocalizedStringKey("InvalidCredentials"))
                                .bold()
                            
                        }
                    }
                    
                    LoginBoxView()
                    
                    
                    // MARK: Terms and Conditions
                    HStack {
                        Button {
                            
                            showTerms = true
                            
                        } label: {
                            HStack {
                                
                                Text(LocalizedStringKey("IRead"))
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                
                            }
                            
                        }
                        
                        // Checkbox
                        Button {
                            
                            agreedToTerms.toggle()
                            
                        } label: {
                            
                            HStack{
                                Image(systemName: agreedToTerms ? "checkmark.square" : "square")
                                    .foregroundColor(.pink)
                            }
                            
                        }
                    }
                    
                    RegionSelectorView()

                    Spacer()
                    
                    // MARK: Reset button
                    if authAPIModel.failedLogin {
                        Button {
                            self.showAlert = true
                        } label: {
                            Image("ladybug.fill")
                        }
                        .alert("Invalid login", isPresented: $showAlert, actions: {
                            
                            Button(LocalizedStringKey("Reset"), role: nil, action: {
                                
                                authAPIModel.logOut()
                                
                                authAPIModel.reloading = false
                                authAPIModel.isReloadingError = false
                            })
                            
                            Button(LocalizedStringKey("OK"), role: nil, action: {})
                            
                        }, message: {
                            let info = LocalizedStringKey("ResetInfo")
                            Text(info)
                        })
                    }
                    
                    // MARK: Log in button
                    if agreedToTerms && authAPIModel.regionCheck {
                        
                        Button {
                            
                            // Dismiss keyboard
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                            DispatchQueue.main.async {
                                authAPIModel.failedLogin = false // Remove error message of authentication
                                authAPIModel.isAuthenticating = true // Start loading animation
                                
                                
                            }
                            
                            Task{
                                await authAPIModel.login(skinModel: skinModel)
                            }
                            
                            
                        } label: {
                            if !authAPIModel.isAuthenticating {
                                ZStack{
                                    CircleView(colour: .pink)
                                        .shadow(color:.pink, radius: 2)
                                    
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(15)
                                        .foregroundColor(.white)
                                    
                                }
                                .frame(width: Constants.dimensions.circleButtonSize, height: Constants.dimensions.circleButtonSize)
                            }
                            else{
                                ZStack{
                                    CircleView(colour: .pink)
                                        .opacity(0.7)
                                        .shadow(color:.pink, radius: 2)
                                    
                                    ProgressView()
                                    
                                }
                                .frame(width: Constants.dimensions.circleButtonSize, height: Constants.dimensions.circleButtonSize)
                                
                            }
                            
                        }
                        
                    }
                    else {
                        
                        ZStack{
                            CircleView(colour: .pink)
                                .shadow(color:.pink, radius: 2)
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .padding(15)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: Constants.dimensions.circleButtonSize, height: Constants.dimensions.circleButtonSize)
                        .opacity(0.5)
                        
                        
                        
                    }
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 35)
            }
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showTerms) {
            TermsView()
                .background(Constants.bgGrey)
                .preferredColorScheme(.dark)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
