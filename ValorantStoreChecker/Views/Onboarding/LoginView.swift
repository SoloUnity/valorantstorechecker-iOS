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
                    
                    LogoView()
                        .frame(width: geo.size.width/4)
                    
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
                    
                    RegionSelectorView()
                    
                    Spacer()
                    
                    
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
                    
                    // Log in button
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
