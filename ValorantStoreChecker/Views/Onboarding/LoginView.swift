//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var agreedToTerms: Bool = false
    
        var body: some View {
            
            
            GeometryReader{ geo in
                VStack(spacing: 15){
                    
                    LogoView()
                        .frame(width: geo.size.width/4)
                    
                    HStack{
                        Text("Login to your Riot Account")
                        Button {
                                                    
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    
                    // Username
                    ZStack {
                        HStack {
                            
                            Image(systemName: "person.circle")
                            
                            TextField("Riot Account Username" , text: $authAPIModel.username)
                                .keyboardType(.default)
                                .autocorrectionDisabled()
                            
                        }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .shadow(color: .white, radius: 2)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    }
                                   
                    //Password
                    ZStack {
                        HStack {
                            
                            Image(systemName: "key")
                            
                            SecureField("Password" , text: $authAPIModel.username)
                                .keyboardType(.default)
                                .autocorrectionDisabled()
                            
                        }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .shadow(color: .white, radius: 2)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    }
                        
                    
                    RegionSelectorView()
                    
                    Spacer()
                    
                    
                    //LoginTestView()
                    
                    
                    
                    // Test Button
                    Button {
                        Task{
                            authAPIModel.username = "rintohsakalover69"
                            authAPIModel.password = "Banana11!!!"
                            await authAPIModel.login()
                        }
                        
                        
                    } label: {
                        ZStack{
                            CircleView(colour: .red)
                                .shadow(color:.pink, radius: 2)
                            
                            Text("Test")
                                .foregroundColor(.white)
                                
                        }
                        .frame(width: 60, height: 60)
                    }
                    
                    Button {
                        Task{
                            await authAPIModel.login()
                        }
                        
                        
                    } label: {
                        ZStack{
                            CircleView(colour: .red)
                                .shadow(color:.pink, radius: 2)
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .padding(15)
                                .foregroundColor(.white)
                                
                        }
                        .frame(width: 60, height: 60)
                    }
                    
                    //Terms and Conditions
                    /*
                     HStack{
                         // TODO: Link to terms and conditions
                         Button {
                             
                         } label: {
                             Text("I have read the terms and conditions")
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
                     }.padding()
                     */
                    
                    
                }
                .padding(50)
            }
            .ignoresSafeArea(.all, edges: .top)
            .background(Color(red: 28/255, green: 28/255, blue: 30/255))
            .preferredColorScheme(.dark)
        }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
