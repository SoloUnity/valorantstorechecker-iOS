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
    @AppStorage("selectedTab") var selectedTab: Tab = .skinList
    @State var searchText : String = ""
    @State var savedText : String = ""
    @State var selectedFilter : String  = ""
    @State var filtered : Bool = false
    @State var selectOwned : Bool = false
    @State var hasScrolled = false
    
    var body: some View {

        ScrollViewReader{ (proxy: ScrollViewProxy) in
            

            ZStack {
                
                // Filter the data
                let search = skinModel.data
                    .filter({ searchText.isEmpty ? (savedText.isEmpty ? true : $0.displayName.lowercased().contains(savedText.lowercased())) : $0.displayName.lowercased().contains(searchText.lowercased())})
                    .filter({selectedFilter.isEmpty ? true : $0.assetPath!.lowercased().contains(selectedFilter.lowercased())})
                    .filter { one in
                        selectOwned ? authAPIModel.ownedSkins.contains { two in
                            one.displayName == two
                        } : true
                    }
                    
                
                ScrollView {
                    
                    scrollDetection
                        .id("top") // Id to identify the top for scrolling

                    Group {
                        
                        
                        if search.count == 0 {
                            // MARK: No search
                            
                            HStack {
                                
                                Spacer()
                                
                                VStack {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(minWidth: 0, maxWidth: 100)
                                    
                                    Text(selectOwned ? LocalizedStringKey("NoOwned") : LocalizedStringKey("EmptySearch"))
                                        .bold()
                                }
                                
                                Spacer()
                            }
                            .padding()
                            
                        }
                        else if selectOwned {
                            
                            HStack {
                                
                                        
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Statistics")
                                        .bold()
                                    
                                    HStack {
                                        
                                        Text("TotalCollectionCost").bold() + Text(":").bold()
                                            
                                        Image("vp")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)

                                        
                                        Text(String(calculateTotal(search: search)))
                                            .bold()
                                         
                                    }

                                }
                                .font(.subheadline)
                                Spacer()
                                 
                            }
                            .padding()
  
                        }
                        
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    if skinModel.data.isEmpty{
                        ProgressView()
                    }
                    else{
                        
                        
                        // MARK: Content
                        LazyVStack(){                            
                            
                            ForEach(0 ..< search.count, id: \.self){ index in
                                
                                if search.count == 1 {
                                    
                                    HStack {
                                        TierBar(contentTierUuid: search[index].contentTierUuid ?? "", clip: "single")
                                        
                                        SkinCardView(skin: search[index], showPrice: true, showPriceTier: true)
                                            .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                            .padding(.vertical)
                                    }
                                    
                                }
                                else if search[index] === search.first {
                                    
                                    HStack {
                                        TierBar(contentTierUuid: search[index].contentTierUuid ?? "", clip: "top")
                                            
                                        SkinCardView(skin: search[index], showPrice: true, showPriceTier: true)
                                            .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                            .padding(.top)
                                        
                                    }
                        
                                    
                                    
                                    Divider()
                                        .padding(.leading)
                                }
                                else if search[index] === search.last {
                                
                                    HStack {
                                        TierBar(contentTierUuid: search[index].contentTierUuid ?? "", clip: "bottom")
                                        
                                        SkinCardView(skin: search[index], showPrice: true, showPriceTier: true)
                                            .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                            .padding(.bottom)
                                    }
                                    
                                    
                                }
                                else {
                                    HStack {
                                        
                                        TierBar(contentTierUuid: search[index].contentTierUuid ?? "")
                                        
                                        VStack {
                                            SkinCardView(skin: search[index], showPrice: true, showPriceTier: true)
                                                .frame(height: (UIScreen.main.bounds.height / Constants.dimensions.cardSize))
                                                
                                            
                                            Divider()
                                                .padding(.leading)
                                        }
                                    }
                                }
                            }
                            
                            
                                
                            
                        }
                        .animation(.default, value: searchText)
                        .animation(.default, value: selectedFilter)
                        .animation(.default, value: selectOwned)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.horizontal)
                        
                        
                    }
                    
                    
                }
                .coordinateSpace(name: "scroll")
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(height: 70)
                }
                .overlay {
                    NavigationSearchBar(title: "SkinIndex", hasScrolled: $hasScrolled, searchText: $searchText, savedText: $savedText, selectedFilter: $selectedFilter, filtered: $filtered, selectOwned: $selectOwned, proxy: proxy)
                    
                }
                .onChange(of: selectedTab, perform: { tab in
                    if tab == .skinList {
                        
                        self.hasScrolled = false
                        proxy.scrollTo("top", anchor: .top)
                        
                    }
                })
                
                
                // MARK: Scroll to top button
                if hasScrolled {
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            GoUpButton(proxy: proxy)
                                .padding(.trailing)
                                .padding(.bottom, (UIScreen.main.bounds.height / Constants.dimensions.upButton))
                            
                        }
                    }
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.hasScrolled = false
                        }
                        
                    }
                }
            }
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in

            Color.clear
                .preference(key: ScrollPreferenceKey.self, 
                            value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                hasScrolled = value < 0
            }
        }
    }
    
    
    func calculateTotal(search: [Skin]) -> Int {
        
        var cost = 0
        
        for skin in search {
            
            let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
            
            if price != "Unknown" {
                cost += Int(price) ?? 0
            }
            
        }
        
        return cost
    }
    
}




 

struct SkinListView_Previews: PreviewProvider {
    static var previews: some View {
        SkinListView()
    }
}

