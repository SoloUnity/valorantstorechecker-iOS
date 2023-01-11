//
//  ChevronView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-24.
//

import SwiftUI

struct ChevronView: View {
    
    @Environment(\.colorScheme) var colourScheme
    @AppStorage("dark") var toggleDark = true
    @AppStorage("autoDark") var auto = false
    
    @State var dummy = false
    var body: some View {
        NavigationLink(destination: HelpView()) {
            EmptyView()
        }
        .foregroundColor(auto ? (colourScheme == .light ? .black : .white) : (toggleDark ? .white : .black))
        
    }
}

