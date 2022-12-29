//
//  TipView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-17.
//

import SwiftUI
import Keychain
import StoreKit

struct TipView: View {
    
    @EnvironmentObject var tipModel : TipModel
    @State var title = LocalizedStringKey("Sponsor")
    @State var dummy = false

    let tips : [Product]
    let keychain = Keychain()

    var body: some View {
        
        HStack{
            
            SettingItemView(itemType: "generic", name: "Show Appreciation", iconBG: .white, iconColour: .red, image: "heart.fill", toggleBool: $dummy)

            Spacer()
            
            Menu {
                ForEach(tips, id: \.id) { tip in
                    tipButton(tip: tip)
                }
                
                if tips.isEmpty {
                    HStack {
                        
                        Text(LocalizedStringKey("NetworkError"))
                            .bold()
                        
                        Spacer()

                    }
                }
            } label: {
                Text(title)
            }
        }
    }
    
    struct tipButton : View {
        
        @EnvironmentObject var tipModel : TipModel
        @EnvironmentObject var alertModel : AlertModel
        @State private var errorTitle = ""
        
        let tip : Product
        
        var body: some View {
            
            Button {
                
                Task {
                    await purchase(alertModel: alertModel)
                }
         
            } label: {
                
                HStack {

                    Text(tip.displayPrice)
                }
            }
        }
        
        
        @MainActor
        func purchase(alertModel: AlertModel) async {
            do {
                
                let _ = try await tipModel.purchase(tip)
                
            } catch StoreError.failedVerification {
                alertModel.alertTipError = true
            } catch {
                print("Failed fuel purchase: \(error)")
            }
        }
        
        
    }
}


