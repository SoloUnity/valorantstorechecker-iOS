//
//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI



struct LaunchView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        // Login View
        
        // Notifications Permissions View
        
        // Home View
        HomeView()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
