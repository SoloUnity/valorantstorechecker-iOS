//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI
import CustomTextField


struct LoginView: View {
    
        @StateObject private var accountListVM = StoreModel()
        @EnvironmentObject var loginModel:LoginModel
    
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var agreedToTerms: Bool = false
    
        var body: some View {
            
            
            GeometryReader{ geo in
                VStack() {
                    
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
                    CustomTF(text: $loginModel.username, placeholder: "Username", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style2, KeyboardType: .default, color: nil)
                    
                    //Password
                    CustomTF(text: $loginModel.password, placeholder: "Password", ImageTF: Image(systemName: "key"), isPassword: true, StylesType: .Style2, KeyboardType: .default, color: nil)
                    
                    RegionSelectorView()
                    
                    Spacer()
                    
                    
                    //LoginTestView()
                    
                    
                    
                    // Test Button
                    Button {
                        loginModel.username = "rintohsakalover69"
                        loginModel.password = "Banana11!!!"
                        loginModel.login()
                        
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
                        
                        loginModel.login()
                        
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
