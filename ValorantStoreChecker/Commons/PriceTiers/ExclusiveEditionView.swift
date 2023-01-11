//
//  ExclusiveEditionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct ExclusiveEditionView: View {
    var body: some View {
        Image("exclusiveEdition")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(red: 235/255, green: 152/255, blue: 100/255), radius: 2)
    }
}

struct ExclusiveEditionView_Previews: PreviewProvider {
    static var previews: some View {
        ExclusiveEditionView()
    }
}
