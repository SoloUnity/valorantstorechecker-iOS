//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI


struct LaunchView: View {
    
    @EnvironmentObject var model:SkinModel
    @EnvironmentObject var loginModel:AuthAPIModel

    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        // Displays login if the user is not authenticated
        if !loginModel.isAuthenticated && !defaults.bool(forKey: "authentication") {
            LoginView()
        }
        else {
            HomeView()
        }

    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
