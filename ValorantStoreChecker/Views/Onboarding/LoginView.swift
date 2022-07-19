//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI
import CustomTextField

struct LoginView: View {
    
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var agreedToTerms: Bool = false
        @State private var region = ""
    
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
                    CustomTF(text: $email, placeholder: "Username", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style2, KeyboardType: .default, color: nil)
                    
                    //Password
                    CustomTF(text: $password, placeholder: "Password", ImageTF: Image(systemName: "key"), isPassword: true, StylesType: .Style2, KeyboardType: .default, color: nil)

                    // TODO: Picker for region
                    HStack{
                        Text("Pick your region:")
                        Picker("Tap Me", selection: $region){
                                        Text("North America")
                                            .tag("NA")
                                        Text("Europe")
                                            .tag("EU")
                                        Text("Asia Pacific")
                                            .tag("AP")
                                        Text("South Korea")
                                            .tag("KO")
                                    }
                    }
                    .accentColor(.white)
                    
                    Spacer()
                    
                    Button {
                        print("Logged in!")
                    } label: {
                        ZStack{
                            CircleView(colour: .red)
                                .shadow(color:.pink, radius: 5)
                            
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
            .background(Color(red: 28/255, green: 28/255, blue: 30/255))
            .ignoresSafeArea(.all, edges: .top)
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
