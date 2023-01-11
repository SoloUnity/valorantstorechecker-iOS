//
//  PremiumEditionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct PremiumEditionView: View {
    var body: some View {
        Image("premiumEdition")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(red: 194/255, green: 93/255, blue: 138/255), radius: 2)
    }
}

struct PremiumEditionView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumEditionView()
    }
}
