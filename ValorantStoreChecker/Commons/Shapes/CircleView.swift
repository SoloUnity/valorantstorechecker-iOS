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
            
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
