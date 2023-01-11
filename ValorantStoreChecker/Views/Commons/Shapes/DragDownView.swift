//
//  DragDownView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-24.
//

import SwiftUI

struct DragDownView: View {
    var body: some View {
        
        HStack {
            Spacer()
            
            Rectangle()
                .cornerRadius(5)
                .foregroundColor(.gray)
                .frame(width: 30, height: 4)
            
            
            Spacer()
        }
    }
}

struct DragDownView_Previews: PreviewProvider {
    static var previews: some View {
        DragDownView()
    }
}
