//
//  StoreModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-11.
//  From https://www.youtube.com/watch?v=JJG3xI5FmFY

import Foundation
import StoreKit
import SwiftUI

// Fetch Products (tip)
// Purchase Product
// Update UI

class TipModel: ObservableObject {
    
    @Published var tips: [Product] = []
    
    func fetchTips() {
        
        Task.init {
            do {
                
                let tips = try await Product.products(for: [
                    "com.solounity.tip1",
                    "com.solounity.tip5",
                    "com.solounity.tip10",
                    "com.solounity.tip20",
                    "com.solounity.tip69",
                ])
                
                DispatchQueue.main.async {
                    self.tips = tips
                }
                
            }
            catch {
                print(error)
            }
        }

    }
    
    func isPurchsed() {
        
        guard let product = tips.first else {
            return
        }
        
        Task.init {
            guard let state = await product.currentEntitlement else {
                return
            }
            
            switch state {
            case .verified(let transaction):
                print(transaction.productID)
            
            case .unverified(_ , _):
                break
                
            }
        }
        
    }
    
    func purchase(index : Int) {
        
        Task.init {
            
            let tips = tips[index]
            
            do {
                let result = try await tips.purchase()
                
                switch result {
                    
                case .success(let verification):
                    
                    switch verification {
                    
                    case .verified(let transaction):
                        print(transaction.productID)
                    
                    case .unverified(_ , _):
                        break
                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            }
            catch {
                print(error)
            }
            
        }
        
    }
}

