//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    
    @State private var agreedToTerms: Bool = false
    @State private var showTerms : Bool = false
    
    
    
    var body: some View {
        
        
        GeometryReader { geo in
            
            
            
            ZStack(alignment: .top) {
                
                

                
                VStack(spacing: 15) {
                    
                    
                    
                    Logo()
                        .frame(width: geo.size.width/4)
                        .padding(.top, 30)
                    
                    // MARK: General Info
                    if !authAPIModel.failedLogin{
                        HStack {
                            Text("Login to your Riot Account")
                                .bold()
                            Button {
                                
                            } label: {
                                Image(systemName: "info.circle")
                            }
                        }
                        
                    }else{
                        Text("Invalid Credentials")
                            .bold()
                    }
                    
                    
                    
                    LoginBoxView()
                    
                    
                    // MARK: Terms and Conditions
                    HStack{
                        Button {
                            
                            showTerms = true
                            
                        } label: {
                            HStack {
                                Image(systemName: "link")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .accentColor(.white)
                                    .frame(width:10, height: 10)
                                
                                Text("I read the terms and conditions.")
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
                    
                    // MARK: Log in button
                    if agreedToTerms && authAPIModel.regionCheck {
                        Button {
                            authAPIModel.failedLogin = false // Remove error message of authentication
                            authAPIModel.isAuthenticating = true // Start loading animation
                            
                            Task{
                                await authAPIModel.login()
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
                                .frame(width: 60, height: 60)
                            }
                            else{
                                ProgressView()
                                    .frame(width: 60, height: 60)
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
                        .frame(width: 60, height: 60)
                        .opacity(0.5)
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                .padding(50)
            }
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $authAPIModel.showMultifactor) {
            MultifactorView()
                .preferredColorScheme(.dark)
                .background(Constants.bgGrey)
        }
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
