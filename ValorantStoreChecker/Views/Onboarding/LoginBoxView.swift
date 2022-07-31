//
//  LoginBoxView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-30.
//

import SwiftUI

struct LoginBoxView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    
    var body: some View {
        VStack{
            // Username
            ZStack {
                HStack {
                    
                    Image(systemName: "person.circle")
                        .foregroundColor(.white)
                    
                    TextField("Username" , text: $authAPIModel.username)
                        .keyboardType(.default)
                        .autocorrectionDisabled()
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        
                    
                }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    .shadow(color: authAPIModel.failedLogin ? .red : .white, radius: 2)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    
            }
                           
            //Password
            ZStack {
                HStack {
                    
                    Image(systemName: "key")
                        .foregroundColor(.white)

                    SecureField("Password" , text: $authAPIModel.password)
                        .keyboardType(.default)
                        .autocorrectionDisabled()
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                    
                }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                    .shadow(color: authAPIModel.failedLogin ? .red : .white, radius: 2)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
            }
            
        }
        .foregroundColor(authAPIModel.failedLogin ? .red : .white)
    }
}

struct LoginBoxView_Previews: PreviewProvider {
    static var previews: some View {
        LoginBoxView()
    }
}
