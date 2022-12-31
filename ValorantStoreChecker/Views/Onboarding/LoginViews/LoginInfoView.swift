//
//  LoginInfoView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-30.
//

import SwiftUI

struct LoginInfoView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @EnvironmentObject private var alertModel : AlertModel
    
    var body: some View {
        // MARK: General Info
        if !authAPIModel.failedLogin {
            
            HStack {
                
                // LOCALIZETEXT
                Text(LocalizedStringKey("Login"))
                    .bold()
                
                Spacer()
                
                Button {
                    
                    alertModel.alertLoginInfo = true
                    
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            
        }else {
            
            HStack {
                
                Text(LocalizedStringKey("InvalidCredentials"))
                    .bold()
                
                Spacer()
                
                // MARK: Reset button for potential bugs
                Button {
                    
                    alertModel.alertBugInfo = true
                    
                } label: {
                    
                    Image(systemName: "ladybug.fill")
                    
                }
            }
        }
        
    }
}

struct LoginInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LoginInfoView()
    }
}
