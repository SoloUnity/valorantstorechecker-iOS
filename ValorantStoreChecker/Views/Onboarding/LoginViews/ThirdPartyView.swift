//
//  ThirdPartyView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-25.
//

import SwiftUI

struct ThirdPartyView: View {
    var body: some View {
        HStack {

            
            Button {
                if let url = URL(string: Constants.URL.googleLogin) {
                    UIApplication.shared.open(url)
                }
            } label: {
                ZStack {
                    Image("facebook")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .frame(height: 24)
                        .padding(.vertical, 3)
                }
                .background(.white)
                .cornerRadius(7.5)
                .frame(height: 45)
                
                    
                    
            }
            
            Spacer()
            
            
            Button {
                if let url = URL(string: Constants.URL.googleLogin) {
                    UIApplication.shared.open(url)
                }
            } label: {
                ZStack {
                    Image("google")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .frame(height: 30)
                }
                .background(.white)
                .cornerRadius(7.5)
                .frame(height: 45)
                
  
            }
            
            Spacer()
            
            
            Button {
                if let url = URL(string: Constants.URL.googleLogin) {
                    UIApplication.shared.open(url)
                }
            } label: {
                
                ZStack {
                    Image(systemName: "apple.logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .frame(height: 22)
                        .padding(.vertical, 4)
                        .foregroundColor(.black)
                }
                .background(.white)
                .cornerRadius(7.5)
                .frame(height: 45)
                
                    
            }
            
        }
    }
}

struct ThirdPartyView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartyView()
    }
}
