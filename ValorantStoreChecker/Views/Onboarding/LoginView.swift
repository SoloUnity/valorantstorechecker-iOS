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
    @EnvironmentObject private var alertModel : AlertModel
    @State private var agreedToTerms: Bool = false
    @State private var showTerms : Bool = false
    @State private var regionCheck : Bool = false
    
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
                                
                                alertModel.alertLoginInfo = true
                                
                            } label: {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.pink)
                            }
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
                    
                    RegionSelectorView(regionCheck: $regionCheck)

                    Spacer()
                    
                    // MARK: Reset button for potential bugs
                    if authAPIModel.failedLogin {
                        
                        Button {
                            
                            alertModel.alertBugInfo = true
                            
                        } label: {
                            Image(systemName: "ladybug.fill")
                        }

                    }
                    
                    // MARK: Log in button
                    if agreedToTerms && regionCheck {
                        
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
        //.preferredColorScheme(.dark)
        .sheet(isPresented: $showTerms) {
            TermsView()
                .background(Constants.bgGrey)
                //.preferredColorScheme(.dark)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
