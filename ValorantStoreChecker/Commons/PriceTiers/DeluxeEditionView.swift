//
//  DeluxeEditionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct DeluxeEditionView: View {
    var body: some View {
        Image("deluxeEdition")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(red: 69/255, green: 154/255, blue: 133/255), radius: 2)
    }
}

struct DeluxeEditionView_Previews: PreviewProvider {
    static var previews: some View {
        DeluxeEditionView()
    }
}
