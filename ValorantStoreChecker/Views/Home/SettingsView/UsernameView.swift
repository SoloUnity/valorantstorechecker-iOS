//
//  UsernameView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI
import Keychain

struct UsernameView: View {
    
    let keychain = Keychain()
    
    var body: some View {
        HStack{
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.pink)
                Image(systemName: "person.circle")
                    .foregroundColor(.white)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.trailing)
            

                
            
            VStack(alignment: .leading) {
                
                Text(keychain.value(forKey: "username") as? String ?? "")
                    .bold()
                
                Text(LocalizedStringKey(getRegionKey()))
                    .font(.footnote)
                
            }
            

                
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
