//
//  DropDownView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-27.
//

import SwiftUI

struct RegionSelectorView: View {
    
    @EnvironmentObject var storeModel:StoreModel
    @State var expand = false
    @State var title = "Select region"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Button {
                expand.toggle()
            } label: {
                
                HStack{
                    Text(title)
                    
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .multilineTextAlignment(.trailing)
                }
                
            }
            
            if expand{
                
                Button {
                    storeModel.region = "na"
                    title = "North America"
                    expand = false
                    
                } label: {
                    Text("North America")
                }
                
                Button {
                    storeModel.region = "eu"
                    title = "Europe"
                    expand = false
                } label: {
                    Text("Europe")
                }
                
                Button {
                    storeModel.region = "ap"
                    title = "Asia Pacific"
                    expand = false
                } label: {
                    Text("Asia Pacific")
                }
                
                Button {
                    storeModel.region = "kr"
                    title = "South Korea"
                    expand = false
                } label: {
                    Text("South Korea")
                }
            }
            
            

        }
        .foregroundColor(.white)
        .padding(7)
        .background(Color.pink)
        .cornerRadius(10)
        .animation(.spring(), value: expand)
        .shadow(color:.pink, radius: 2)
    }
}

struct RegionSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSelectorView()
    }
}
