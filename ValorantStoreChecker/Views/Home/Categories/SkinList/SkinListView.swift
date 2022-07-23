//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SkinListView: View {
    
    @ObservedObject var model = ContentModel()
    @State var searchText:String = ""

    
    
    var body: some View {
        VStack(alignment: .leading){
            
                if model.data.isEmpty{
                    ProgressView()
                }
                else{
                    SkinSectionView(skins: model.data)
                }
                
                
            
            
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

