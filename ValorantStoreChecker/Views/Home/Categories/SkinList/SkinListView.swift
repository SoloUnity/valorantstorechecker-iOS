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
            VStack(spacing: 0){
                
                SearchBar(text: $searchText)
                
                ScrollViewReader{ (proxy: ScrollViewProxy) in
                    ScrollView {
                        
                        if model.data.isEmpty{
                            ProgressView()
                        }
                        else{
                            
                            // MARK: Search
                            let search = model.data.filter({ searchText.isEmpty ? true : $0.displayName.lowercased().contains(searchText.lowercased()) })
                            
                            LazyVStack(spacing: 11){
                                
                                ForEach(search){ skin in
                                    
                                    SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                        .frame(height: (UIScreen.main.bounds.height / 6.5))
                                    
                                    
                                }
                                
                                // MARK: Scroll to top button
                                if search.count > 5{
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
                            .padding(10)
                            .id("top") // Id to identify the top for scrolling
                            .tag("top") // Tag to identify the top for scrolling
                        }
                        
                        
                        
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

