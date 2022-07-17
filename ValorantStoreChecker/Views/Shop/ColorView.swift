//
//  ColorView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct ColorView: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]
    
    var body: some View {
        (colors.randomElement() ?? .gray)
                .cornerRadius(10)
                .frame(minHeight: 40)
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView()
    }
}
