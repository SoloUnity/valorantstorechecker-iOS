//
//  MenuItemView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

// MARK: Menu Item
struct MenuItemView: View {
    
    @EnvironmentObject var skinModel : SkinModel
    @Binding var selectedFilter : String
    @Binding var filterName : String
    var filter : String
    var label : String //useless now but i dont feel like changing all the other code to remove this
    @Binding var selectOwned : Bool
    var proxy : ScrollViewProxy
    
    var body: some View {
        Button {
            selectedFilter = filter
            filterName = labelName()
            proxy.scrollTo("top", anchor: .top)
        } label: {
            if selectedFilter == filter {
                Label(labelName(), systemImage: "checkmark")
            }
            else {
                Text(labelName())
            }
        }
        
    }
    
    func labelName() -> String {
        let filterList = skinModel.standardSkins.filter({$0.assetPath!.contains(filter)})
        
        let displayName = filterList[0].displayName
        
        let language = Bundle.main.preferredLocalizations        
        
        return getLanguageName(language: language[0], displayName: displayName)
    }
    
}


