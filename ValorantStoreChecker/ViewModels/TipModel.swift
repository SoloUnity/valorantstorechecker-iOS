//
//  StoreModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-11.
//

import Foundation
import StoreKit
import SwiftUI

// Fetch Products (tip)
// Purchase Product
// Update UI
/*
class TipModel: ObservableObject {
    
    var tips: [Product] = []
    
    func fetchTips() {
        
        Task.init {
            do {
                
                let tips = try await Product.products(for: ["com.tip"])
                DispatchQueue.main.async {
                    self.tips = tips
                }
                
            }
            catch {
                print(error)
            }
        }

    }
    
    func purchase() {
        
        Task.init {
            
            guard let tips = tips.first else { return }
            
            do {
                let result = try await tips.purchase()
                switch result {
                    
                case .success(let verification):
                    <#code#>
                case .userCancelled:
                    <#code#>
                case .pending:
                    <#code#>
                @unknown default:
                    <#code#>
                }
            }
            catch {
                print(error)
            }
            
        }
        
    }
}
*/
