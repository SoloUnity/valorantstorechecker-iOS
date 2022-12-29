//
//  ShopBottomBarView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-01.
//

import SwiftUI

struct ShopBottomBarView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    var body: some View {
        
        HStack {
            
            // MARK: VP
            Image("vp")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)

            
            if authAPIModel.vp != "" {
                Text(authAPIModel.vp)
                    .font(.caption)
                    .bold()

            }
            else {
                Text(authAPIModel.defaults.string(forKey: "vp") ?? "Unknown")
                    .font(.caption)
                    .bold()

            }
            
            
            Spacer()
            
            // MARK: RP
            Image("rp")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
            
            if authAPIModel.rp != "" {
                Text(authAPIModel.rp)
                    .font(.caption)
                    .bold()
            }
            else {
                Text(authAPIModel.defaults.string(forKey: "rp") ?? "Unknown")
                    .font(.caption)
                    .bold()

            }
        }
        .padding(.top, 5)
        .padding(.horizontal)
        .padding(.bottom)

    }
}

struct ShopBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        ShopBottomBarView()
    }
}
