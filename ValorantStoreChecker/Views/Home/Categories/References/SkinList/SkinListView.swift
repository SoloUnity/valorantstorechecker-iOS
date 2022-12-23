//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI



struct SkinListView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    @State var searchText : String = ""
    @State var selectedFilter : String  = ""
    
    @State var simulatedPricing : Bool = false
    @State var filtered : Bool = false
    @State var selectOwned : Bool = false
    @State var isEditing : Bool = false
    
    var body: some View {
        
        ZStack {

            GeometryReader{ geo in
                VStack(spacing: 0){
                    
                    ScrollViewReader{ (proxy: ScrollViewProxy) in
                        
                        HStack {
                            SearchBar(text: $searchText, isEditing: $isEditing)
                                .onChange(of: searchText) { newValue in
                                    proxy.scrollTo("top", anchor: .top)
                                }
                                .padding(.leading, -10)
                            
                            Spacer()
                            
                            if !isEditing {
                                
                                FilterView(selectedFilter: $selectedFilter, selectOwned: $selectOwned, filtered: $filtered, proxy: proxy)
                                
                            }
                            else if isEditing {
                                Button {
                                    // Dismiss keyboard
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    
                                    withAnimation(.easeOut(duration: 0.15)) {
                                        self.isEditing = false
                                    }

                                    self.searchText = ""
                                } label: {
                                    Text("Cancel")
                                        .tint(.pink)
                                }

                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        ScrollView {
                            
                            if skinModel.data.isEmpty{
                                ProgressView()
                            }
                            else{
                                
                                // MARK: Search
                                
                                
                                // Filter the data
                                let search = skinModel.data.filter({ searchText.isEmpty ? true : $0.displayName.lowercased().contains(searchText.lowercased())}).filter({selectedFilter.isEmpty ? true : $0.assetPath!.lowercased().contains(selectedFilter.lowercased())}).filter { one in
                                    selectOwned ? authAPIModel.owned.contains { two in
                                        one.displayName == two
                                    } : true
                                }
                                
                                
                                LazyVStack(spacing: 11){
                                    
                                    
                                    ForEach(search){ skin in
                                        
                                        SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                            .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                            .padding(.horizontal)
                                        
                                    }
                                    
                                    
                                    // MARK: Scroll to top button
                                    if search.count > 5 {
                                        GoUpButton(proxy: proxy)
                                    }
                                    else if search.count == 0 {
                                        // MARK: No search item button
                                        VStack {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(minWidth: 0, maxWidth: 100)
                                                .foregroundColor(.white)
                                            
                                            Text(selectOwned ? LocalizedStringKey("NoOwned") : LocalizedStringKey("EmptySearch"))
                                        }
                                        .padding(.top, (UIScreen.main.bounds.height / 4))
                                        .opacity(0.5)

                                    }
                                    
                                    
                                }
                                .id("top") // Id to identify the top for scrolling
                                .animation(.default, value: searchText)
                                .animation(.default, value: selectedFilter)
                                .animation(.default, value: selectOwned)
                                
                                
                            }
                            //AdPaddingView()
                        }
                    }
                }
                
                
                
            }
            .padding(.bottom, 1)
            

        }
        
        
        
        
        
        
    }
    
    
    
    
    
}

struct SkinListView_Previews: PreviewProvider {
    static var previews: some View {
        SkinListView()
    }
}

