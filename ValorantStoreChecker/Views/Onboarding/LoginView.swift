//
//  LoginView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct LoginView: View {
    
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var agreedToTerms: Bool = false
        
        var body: some View {

                VStack() {
                    

                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    
                        
                    
                    Text("Login to your Riot Account")

                    TextField("Username", text: $email)

                    SecureField("Password", text: $password)

                    // Picker for region
                    
                    Toggle(isOn: $agreedToTerms) {
                        Text("Agree to terms and conditions")
                    }.toggleStyle(SwitchToggleStyle(tint: .red))
                        
                    

                    Button(action: {
                        print("Logged in!")
                    }){
                        HStack{
                            ZStack{
                                CircleView(colour: .red)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(15)
                                    .foregroundColor(.white)
                                    
                            }
                            .frame(width: 60, height: 60)
                            
                            Spacer()
                        }
                        
                        
                        
                        
                    }
                    
                    Spacer()
                }
                //.foregroundColor(.white)
                .ignoresSafeArea(.all, edges: .top)
                .padding(50)
                //.background(.black)
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
