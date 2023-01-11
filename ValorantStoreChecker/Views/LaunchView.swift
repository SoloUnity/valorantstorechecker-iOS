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
    @AppStorage("background") var background = "Background 3"

    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            
            
            
            // Displays login if the user is not authenticated
            if !isAuthenticated {
                
                LoginView()
                    .environment(\.colorScheme, .dark)
                
            }
            else if (!authorizeDownload && !authAPIModel.downloadButtonClicked) || (!downloadBarFinish && !authAPIModel.downloadBarFinish) {
                
                DownloadView()
                    .environment(\.colorScheme, .dark)
                
            }
            else {
                
                HomeView()
                    .background{
                        Image(background)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.all)
                    }
            }
            
            AlertView()
            
        }
        .sheet(isPresented: $authAPIModel.multifactor) {
            MultifactorView()
                .environment(\.colorScheme, .dark)
                .background(Constants.bgGrey)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
