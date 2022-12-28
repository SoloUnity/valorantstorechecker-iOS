//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI
import StoreKit

struct LaunchView: View {
    
    @EnvironmentObject private var skinModel:SkinModel
    @EnvironmentObject private var authAPIModel:AuthAPIModel
    @AppStorage("authentication") var isAuthenticated = false
    //@Environment(\.scenePhase) private var phase
    
    
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack (alignment: .top){
            
            // Displays login if the user is not authenticated
            if !isAuthenticated && !defaults.bool(forKey: "authentication") {
                
                LoginView()
                
            }
            else if (!defaults.bool(forKey: "authorizeDownload") && !authAPIModel.downloadImagePermission) || (!defaults.bool(forKey: "downloadBarFinish") && !authAPIModel.downloadBarFinish) {
                
                DownloadView()
                
            }
            else {
                ContentView()
                //HomeView()

            }
            

            
        }
        .sheet(isPresented: $authAPIModel.showMultifactor) {
            MultifactorView()
                //.preferredColorScheme(.dark)
                .background(Constants.bgGrey)
        }
        .alert(LocalizedStringKey("ErrorTitle"), isPresented: $authAPIModel.isError, actions: {
            
            if authAPIModel.isReloadingError && (authAPIModel.rememberPassword || defaults.bool(forKey: "rememberPassword")) {
                
                
                Button(LocalizedStringKey("OK"), role: nil, action: {
                    authAPIModel.reloading = false
                    authAPIModel.isReloadingError = false
                })
                
            }
            else if authAPIModel.isReloadingError {
                
                Button(LocalizedStringKey("SignOut"), role: nil, action: {
                    
                    authAPIModel.logOut()
                    
                    authAPIModel.reloading = false
                    authAPIModel.isReloadingError = false
                })
                
                
                Button(LocalizedStringKey("OK"), role: nil, action: {
                    authAPIModel.reloading = false
                    authAPIModel.isReloadingError = false
                })
                
            }
            else {
                
                Button(LocalizedStringKey("CopyError"), role: nil, action: {
                    
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = authAPIModel.errorMessage
                    
                    authAPIModel.reloading = false
                    authAPIModel.isReloadingError = false
                    
                })
                
                Button(LocalizedStringKey("OK"), role: nil, action: {
                    authAPIModel.reloading = false
                    authAPIModel.isReloadingError = false
                    
                })
                
            }
            
        }, message: {
            
            if authAPIModel.isReloadingError && (authAPIModel.rememberPassword || defaults.bool(forKey: "rememberPassword")) {
                
                Text(LocalizedStringKey("ErrorMessage2"))
            }
            else if authAPIModel.isReloadingError {
                
                Text(LocalizedStringKey("ErrorMessage1"))
            }
            else {
                Text(authAPIModel.errorMessage)
            }
            
            
            
        })
        
        
        
        
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
