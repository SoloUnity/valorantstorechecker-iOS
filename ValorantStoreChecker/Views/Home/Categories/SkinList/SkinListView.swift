//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SkinListView: View {
    @State var searchText:String = ""
    
    var body: some View {
        GeometryReader{ geo in
            SearchBar(text: $searchText)
                .padding()
        }
    }
}

struct SkinListView_Previews: PreviewProvider {
    static var previews: some View {
        SkinListView()
    }
}
