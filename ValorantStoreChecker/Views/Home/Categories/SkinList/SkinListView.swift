//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SkinListView: View {
    
    @EnvironmentObject var model:SkinModel
    @State var searchText:String = ""

    
    var body: some View {

        GeometryReader{ geo in
            VStack{
                
                SearchBar(text: $searchText)
                    
                ScrollView{
                    
                    if model.data.isEmpty{
                        ProgressView()
                    }
                    else{
                        

                        LazyVStack(spacing: 13){
                            ForEach(model.data.filter({ searchText.isEmpty ? true : $0.displayName.lowercased().contains(searchText.lowercased()) })){ skin in
                                
                                SkinCardView(skin: skin, showPriceTier: false)
                                    .frame(height: (geo.size.height / 5.75))
                                
                            
                            }
                            
                        }
                        .padding(10)
                    }
                    
                }

            }
            .padding(10)
            
        }
        
    }
}

struct SkinListView_Previews: PreviewProvider {
    static var previews: some View {
        SkinListView()
    }
}

