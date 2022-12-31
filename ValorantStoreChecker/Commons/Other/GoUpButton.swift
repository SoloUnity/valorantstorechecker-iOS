//
//  GoUpButton.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct GoUpButton: View {
    
    var proxy : ScrollViewProxy
    
    var body: some View {
        Button {
            // Scroll to top
            withAnimation {
                proxy.scrollTo("top", anchor: .top)
            }
            haptic()
            
        } label: {
            
            Image(systemName: "arrow.up")
                .foregroundColor(.pink)
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(15)
                .background(.ultraThinMaterial, in: Circle())
                
        }
    }
}

