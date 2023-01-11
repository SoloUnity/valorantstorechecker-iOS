//
//  SelectEditionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SelectEditionView: View {
    var body: some View {
        Image("selectEdition")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(red: 107/255, green: 157/255, blue: 220/255), radius: 2)
    }
}

struct SelectEditionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectEditionView()
    }
}
