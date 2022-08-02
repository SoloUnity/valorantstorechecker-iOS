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
                .shadow(color: .white, radius: 1)
                .frame(width: 15, height: 15)
                .padding(.leading)
                .padding(.vertical, 10)
            
            if authAPIModel.vp != "" {
                Text(authAPIModel.vp)
                    .font(.caption)
                    .bold()
                    .padding(.vertical, 5)
            }
            else {
                Text(authAPIModel.defaults.string(forKey: "vp") ?? "Unknown")
                    .font(.caption)
                    .bold()
                    .padding(.vertical, 5)
            }
            
            
            Spacer()
            
            // MARK: RP
            Image("rp")
                .resizable()
                .scaledToFit()
                .shadow(color: .white, radius: 1)
                .frame(width: 15, height: 15)
                .padding(.vertical, 10)
            
            if authAPIModel.rp != "" {
                Text(authAPIModel.rp)
                    .font(.caption)
                    .bold()
                    .padding(.vertical, 5)
                    .padding(.trailing)
            }
            else {
                Text(authAPIModel.defaults.string(forKey: "rp") ?? "Unknown")
                    .font(.caption)
                    .bold()
                    .padding(.vertical, 5)
                    .padding(.trailing)
            }
        }
        .background(Blur(radius: 25, opaque: true))
        .cornerRadius(10)
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 3)
                .offset(y: -1)
                .offset(x: -1)
                .blendMode(.overlay)
                .blur(radius: 0)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                }
        }
    }
}

struct ShopBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        ShopBottomBarView()
    }
}
