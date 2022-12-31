//
//  RegionView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI
import Keychain

struct RegionView: View {
    
    @State var country = getRegionIndex()
    let keychain = Keychain()
    
    
    var body: some View {
        HStack{
            
            switch keychain.value(forKey: "region") as? String ?? "na" {
            case "na":
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.green)
                    Image(systemName: "globe.americas.fill")
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.trailing)

                
            case "eu":
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.green)
                    Image(systemName: "globe.europe.africa")
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.trailing)
                
                
                
            case "ap":
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.green)
                    Image(systemName: "globe.asia.australia.fill")
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.trailing)
                

                
            case "kr":
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.green)
                    Image(systemName: "globe.asia.australia.fill")
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.trailing)
                
                
                
            default:
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.green)
                    Image(systemName: "globe.americas.fill")
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.trailing)
                
            }
            
            Spacer()
            
            Picker(LocalizedStringKey("Region"), selection: $country){
                
                Text(LocalizedStringKey("Americas"))
                    .tag(0)
                
                Text(LocalizedStringKey("Europe"))
                    .tag(1)
                
                Text(LocalizedStringKey("AsiaPacific"))
                    .tag(2)
                
                Text(LocalizedStringKey("SouthKorea"))
                    .tag(3)
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: country) { region in
                if region == 0 {
                    let  _ = keychain.save("na", forKey: "region")
                }
                else if region == 1 {
                    let  _ = keychain.save("eu", forKey: "region")
                }
                else if region == 2 {
                    let  _ = keychain.save("ap", forKey: "region")
                }
                else if region == 3 {
                    let  _ = keychain.save("kr", forKey: "region")
                }
            }
        }
    }
}

// Helper Function
func getRegionIndex() -> Int {
    
    let region = getRegionKey()
    
    if region == "Americas" {
        return 0
    }
    else if region == "Europe" {
        return 1
    }
    else if region == "AsiaPacific" {
        return 2
    }
    else if region == "SouthKorea" {
        return 3
    }
    
    return 0
}

struct RegionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionView()
    }
}
