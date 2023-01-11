//
//  SearchBar.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI


struct SearchBar: View {
    
    private enum Field : Int, Hashable {
        case big
    }
    
    @FocusState private var focusField : Field?
    
    @Binding var text: String
    @Binding var isEditing :  Bool
    @Binding var showSearch : Bool
    @Binding var savedText : String
    @Binding var hasScrolled : Bool
    
 
    var body: some View {
        
        TextField(showSearch ? LocalizedStringKey("Search") : "", text: $text)
            .padding(.vertical, (hasScrolled && !isEditing) ? 0 : 10)
            .padding(.leading, 35)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .focused($focusField, equals: .big)
            .submitLabel(.search)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if isEditing {
                        Button(action: {
                            self.savedText = ""
                            self.text = ""
                            
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            }
            .onTapGesture {
                
                if !showSearch {
                    self.text = self.savedText
                }
                
                withAnimation(.easeIn(duration: 0.15)) {
                    self.isEditing = true
                }
                
                withAnimation(.spring(response: 0.4, dampingFraction: 0.9)) {
                    self.showSearch = true
                }
                
                self.focusField = .big

            }
            .onSubmit {
                
                self.savedText = text
                self.text = ""
                
                withAnimation(.easeOut(duration: 0.15)) {
                    self.isEditing = false
                }
                
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    self.showSearch = false
                }
                
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
         
                
            }
            .frame(maxWidth: showSearch ? .infinity : 0)
            .padding(.trailing, showSearch ? 0 : .none)
    }
}


