//
//  AssetManagementView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-29.
//

import SwiftUI

struct AssetManagementView: View {
    
    @AppStorage("networkType") var networkType = "both"
    @AppStorage("autoPlay") var autoPlay = true
    
    var body: some View {
        Form {
            Section() {
                
                //LOCALIZETEXT
                SettingItemView(itemType: "toggle", name: "Autoplay Videos", iconBG: .orange, iconColour: .white, image: "arrowtriangle.forward.circle.fill", toggleBool: $autoPlay)
                
                HStack{
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.teal)
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.trailing)
                    
                    Spacer()

                    //LOCALIZETEXT
                    Picker("Download New Assets", selection: $networkType){
                        
                        Text("Both")
                            .tag("both")
                        
                        Text("Wifi Only")
                            .tag("wifi")
                        
                        Text("Cellular Only")
                            .tag("cellular")
                        
                        Text("Never")
                            .tag("never")
                    }
                    .pickerStyle(MenuPickerStyle())

                }
            }
        }
        .navigationBarTitle("Manage Assets")
    }
}

struct AssetManagementView_Previews: PreviewProvider {
    static var previews: some View {
        AssetManagementView()
    }
}
