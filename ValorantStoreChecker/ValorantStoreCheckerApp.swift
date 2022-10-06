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
    
    /*
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    */
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .preferredColorScheme(.dark)
        }
    }
}
