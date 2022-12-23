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
            withAnimation { proxy.scrollTo("top", anchor: .top) }
            
        } label: {
            
            HStack{
                
                Spacer()
                
                Image(systemName: "arrow.up")
                    .resizable()
                    .scaledToFit()
                    .padding(15)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(maxHeight: 50)
            .background(Blur(radius: 25, opaque: true))
            .cornerRadius(10)
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 3)
                    .offset(y: -1)
                    .offset(x: -1)
                    .blendMode(.overlay)
                    .blur(radius: 0)
                    .mask {
                        RoundedRectangle(cornerRadius: 10)
                    }
            }
        }
    }
}

