//
//  ImageAndTextLogo.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-27.
//

import SwiftUI

struct ImageAndTextLogo: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
                .shadow(color:.red, radius: 3)
            
            Image("textlogo")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
                .shadow(color:.red, radius: 3)
                .padding(10)
            
            Spacer()
        }
    }
}

struct ImageAndTextLogo_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextLogo()
    }
}
