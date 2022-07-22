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
    var urlString = "https://valorant-api.com/v1/weapons/skins"
    
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView{
                if model.data.isEmpty{
                    ProgressView()
                        .onAppear() {
                            model.isDone = false
                            model.fetchData(urlString: urlString)
                        }
                        .disabled(!model.isDone)
                }
                else{
                    SkinSectionView(skins: model.data)
                }
                
                
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

