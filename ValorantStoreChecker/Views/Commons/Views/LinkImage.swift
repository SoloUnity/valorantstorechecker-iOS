//
//  Link.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-18.
//

import SwiftUI

struct LinkImage: View {
    var body: some View {
        Image(systemName: "link")
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
    }
}

struct Link_Previews: PreviewProvider {
    static var previews: some View {
        LinkImage()
    }
}
