//
//  SearchBar.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .autocorrectionDisabled()
                .padding(7)
                .padding(.horizontal, 25)
                .background(Constants.cardGrey)
                .cornerRadius(8)
                .shadow(color: .white, radius: 2)
                .submitLabel(.search)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                // Dismiss keyboard
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                self.isEditing = false
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
