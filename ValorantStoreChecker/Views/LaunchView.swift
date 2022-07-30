//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI


struct LaunchView: View {
    
    @EnvironmentObject var model:SkinModel
    @EnvironmentObject var loginModel:AuthAPIModel
    
    var body: some View {
        
        if !loginModel.isAuthenticated{
            LoginView()
                .animation(.easeInOut, value: loginModel.isAuthenticated)
        }
        else{
            HomeView()
                .animation(.easeInOut, value: loginModel.isAuthenticated)
        }
            
        
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
