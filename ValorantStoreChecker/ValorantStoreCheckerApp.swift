//
//  ValorantStoreCheckerApp.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

@main
struct ValorantStoreCheckerApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(SkinModel())
                .environmentObject(LoginModel())
        }
    }
}
