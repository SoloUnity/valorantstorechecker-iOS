//
//  NavigationSearchBar.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-27.
//

import SwiftUI

struct NavigationSearchBar: View {

    @Environment(\.colorScheme) var colourScheme
    @AppStorage("dark") var toggleDark = true
    @AppStorage("autoDark") var auto = false
    @AppStorage("filterName") var filterName : String = ""

    var title: String = ""
    @Binding var hasScrolled: Bool
    @Binding var searchText : String
    @Binding var savedText : String
    @Binding var selectedFilter : String
    @Binding var selectOwned : Bool
    var proxy : ScrollViewProxy
    @State var isEditing : Bool = false
    @State var showSearch = false

    var body: some View {
        
        ZStack {
            
            if (toggleDark  || (auto && colourScheme == .dark)) && hasScrolled && isEditing {
                Color.clear
                    .background(.black)
                    .opacity(hasScrolled ? 1 : 0)
            }
            else if (!toggleDark  || (auto && colourScheme == .light)) && hasScrolled && isEditing {
                Color.clear
                    .background(.white)
                    .opacity(hasScrolled ? 1 : 0)
            }
            else {
                Color.clear
                    .background(.ultraThinMaterial)
                    .opacity(hasScrolled ? 1 : 0)
            }
            
            
            
            HStack {
                
                HStack {
                    if !showSearch {
                        
                        HStack {
                            Logo()
                                .padding(hasScrolled ? 0 : 6)
                            
                            
                            Group {
                                if filterName == "" {
                                    Text(LocalizedStringKey(title))
                                        .font(.system(size: 34, weight: .bold, design: .default))
                                        .minimumScaleFactor(0.4)
                                        .padding(.trailing)
                                        
                                }
                                else {
                                    Text(LocalizedStringKey(filterName))
                                        .font(.system(size: 34, weight: .bold, design: .default))
                                        .minimumScaleFactor(0.4)
                                        .padding(.trailing)
                                }
                            }
                            .animation(.default, value: filterName)
                            
                            
                                
                                
                        }
                        
                        Spacer()
                    }
                    
                    
                    SearchBar(text: $searchText, isEditing: $isEditing, showSearch: $showSearch, savedText: $savedText, hasScrolled: $hasScrolled)
                        .onChange(of: searchText) { newValue in
                            proxy.scrollTo("top", anchor: .top)
                        }
                    
                    if !showSearch {
                        FilterView(selectedFilter: $selectedFilter, selectOwned: $selectOwned, filterName: $filterName, hasScrolled: $hasScrolled, proxy: proxy)
                            
                    }
                        
                }
                

                
                if showSearch && isEditing{
                    Button {
                        // Dismiss keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                        withAnimation(.easeOut(duration: 0.15)) {
                            self.isEditing = false
                            self.showSearch = false
                        }
                        
                        self.searchText = ""
                        self.savedText = ""

                    } label: {
                        Text("Cancel")
                    }
                }

                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)


        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
        
        
        
    }
}
