//
//  SkinSectionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-21.
//

import SwiftUI

struct SkinSectionView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var isDetailViewShowing = false
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
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
            }
            .padding(10)
        }
        .padding()
    }
}



