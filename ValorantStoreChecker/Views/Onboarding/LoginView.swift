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
    
        var body: some View {
            
            
            GeometryReader{ geo in
                VStack() {
                    
                    LogoView()
                        .frame(width: geo.size.width/4)

                    Text("Login to your Riot Account")
                    
                    CustomTF(text: $email, placeholder: "Username", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style2, KeyboardType: .default, color: nil)
                    
                    CustomTF(text: $password, placeholder: "Password", ImageTF: Image(systemName: "key"), isPassword: true, StylesType: .Style2, KeyboardType: .default, color: nil)

                    // Picker for region
                    
                    Button {
                        agreedToTerms.toggle()
                    } label: {
                        HStack{
                            Text("Agreed to terms and conditions")
                            Image(systemName: agreedToTerms ? "checkmark.square" : "square")
                                .accentColor(.red)
                        }
                        
                    }

                    Spacer()
                    
                    Button {
                        print("Logged in!")
                    } label: {
                        ZStack{
                            CircleView(colour: .red)
                                .shadow(color:.red, radius: 5)
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .padding(15)
                                .foregroundColor(.white)
                                
                        }
                        .frame(width: 60, height: 60)
                    }
                    
                    Spacer()

                    
                }
                .padding(50)
            }
            .ignoresSafeArea(.all, edges: .top)
            
            
            
                
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
