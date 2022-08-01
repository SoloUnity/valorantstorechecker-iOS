//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    @State private var agreedToTerms: Bool = false
    
    var body: some View {
        
        
        GeometryReader{ geo in
            VStack(spacing: 15){
                
                Logo()
                    .frame(width: geo.size.width/4)
                    .padding(.top, 30)
                
                
                
                if !authAPIModel.failedLogin{
                    HStack{
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
                
                //Terms and Conditions
                HStack{
                    Button {
                        
                    } label: {
                        Text("I read the terms and conditions.")
                            .foregroundColor(.white)
                    }
                    
                    // Checkbox
                    Button {
                        agreedToTerms.toggle()
                    } label: {
                        HStack{
                            Image(systemName: agreedToTerms ? "checkmark.square" : "square")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                RegionSelectorView()
                
                Spacer()
                
                // Log in button
                Button {
                    authAPIModel.failedLogin = false
                    authAPIModel.isAuthenticating = true
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
            .padding(50)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $authAPIModel.showMultifactor) {
            MultifactorView()
                .preferredColorScheme(.dark)
                .background(Constants.bgGrey)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
