//
//  UltraEditionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct UltraEditionView: View {
    var body: some View {
        Image("ultraEdition")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(red: 245/255, green: 215/255, blue: 117/255), radius: 2)
    }
}

struct UltraEditionView_Previews: PreviewProvider {
    static var previews: some View {
        UltraEditionView()
    }
}
