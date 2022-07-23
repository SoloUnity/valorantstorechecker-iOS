//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SkinListView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var isDetailViewShowing = false
    @State var searchText:String = ""

    
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack{
                
                
                ScrollView{
                    if model.data.isEmpty{
                        ProgressView()
                    }
                    else{
                        
                        
                        
                        VStack(spacing: 13){
                            ForEach(model.data){ skin in
                                
                                Button {
                                    self.isDetailViewShowing = true
                                    
                                } label: {
                                    
                                    SkinCardView(skin: skin)
                                        .frame(height: (geo.size.height / 5.75))

                                }
                            
                            }
                            
                        }
                        .padding(10)
                         
                         
                    }
                    
                }
            }
            .padding()
            
        }
    }
}

struct SkinListView_Previews: PreviewProvider {
    static var previews: some View {
        SkinListView()
    }
}

