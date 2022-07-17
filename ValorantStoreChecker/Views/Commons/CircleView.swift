//
//  CircleView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct CircleView: View {
    var colour = Color.white
    
    var body: some View {
        Circle()
            .foregroundColor(colour)
            .shadow(color: Color(.sRGB, red: 1, green: 0, blue: 0, opacity: 0.5), radius: 5)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
