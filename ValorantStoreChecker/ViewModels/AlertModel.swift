//
//  AlertModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-29.
//

import Foundation

class AlertModel : ObservableObject {
    
    // Login Alerts
    @Published var alertLoginInfo = false
    @Published var alertBugInfo = false
    
    // SkinCardDetailView Alert
    @Published var alertPriceInfo = false
    
    // ShopTopBarView
    @Published var alertPromptReview = false
    @Published var alertNoNetwork = false
    
    // TipView
    @Published var alertTipError = false
    
}
