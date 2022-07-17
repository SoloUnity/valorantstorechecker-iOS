//
//  RectangleView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI

struct RectangleView: View {
    
    var colour:Color
    
    var body: some View {
        Rectangle()
            .foregroundColor(colour)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}


