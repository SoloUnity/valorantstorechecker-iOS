//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI
import StoreKit

struct LaunchView: View {
    
    @EnvironmentObject private var authAPIModel:AuthAPIModel
    @AppStorage("authentication") var isAuthenticated = false
    @AppStorage("authorizeDownload") var authorizeDownload = false
    @AppStorage("downloadBarFinish") var downloadBarFinish = false
    @AppStorage("rememberPassword") var rememberPassword = false

    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            
            
            
            // Displays login if the user is not authenticated
            if !isAuthenticated {
                
                LoginView()
                
            }
            else if (!authorizeDownload && !authAPIModel.downloadImagePermission) || (!downloadBarFinish && !authAPIModel.downloadBarFinish) {
                
                DownloadView()
                
            }
            else {
                HomeView()
            }
            
            AlertView()
            
        }
        .sheet(isPresented: $authAPIModel.showMultifactor) {
            MultifactorView()
                //.preferredColorScheme(.dark)
                .background(Constants.bgGrey)
        }
        
        
        
        
        
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
