//
//  CopyrightView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct CopyrightView: View {
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(LocalizedStringKey("Copyright"))
                    .bold()
                    .font(.title3)
                
                
                Text(LocalizedStringKey("CopyrightNotice"))
                    .font(.footnote)
                
                
                
            }
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
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

struct CopyrightView_Previews: PreviewProvider {
    static var previews: some View {
        CopyrightView()
    }
}