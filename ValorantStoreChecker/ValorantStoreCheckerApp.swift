//
//  ValorantStoreCheckerApp.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
///

import SwiftUI
//import GoogleMobileAds

@main
struct ValorantStoreCheckerApp: App {
    
    @AppStorage("dark") var toggleDark = false
    @AppStorage("autoDark") var auto = false
    
    var body: some Scene {
        WindowGroup {
            
            SplashScreenView()
                .preferredColorScheme(auto ? nil : (toggleDark ? .dark : .light))

        }
    }
}
