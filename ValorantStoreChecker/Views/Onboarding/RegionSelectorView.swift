//
//  DropDownView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-27.
//

import SwiftUI

struct RegionSelectorView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @State var expand = false
    @State var title = "Select region"
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Button {
                
                // Dismiss keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
                expand.toggle()
            } label: {
                
                HStack{
                    Text(title)
                        .padding(.bottom, 4)
                    
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .multilineTextAlignment(.trailing)
                }
                
            }
            
            if expand{
                
                if title != "North America" {
                    Button {
                        defaults.set("na", forKey: "region")
                        title = "North America"
                        expand = false
                        
                    } label: {
                        Text("North America")
                    }
                }
                
                
                if title != "Europe" {
                    Button {
                        defaults.set("eu", forKey: "region")
                        title = "Europe"
                        expand = false
                    } label: {
                        Text("Europe")
                    }
                }
                
                
                if title != "Asia Pacific" {
                    Button {
                        defaults.set("ap", forKey: "region")
                        title = "Asia Pacific"
                        expand = false
                    } label: {
                        Text("Asia Pacific")
                    }
                }
                
                
                if title != "South Korea" {
                    Button {
                        defaults.set("kr", forKey: "region")
                        title = "South Korea"
                        expand = false
                    } label: {
                        Text("South Korea")
                    }
                }
            }
        }
        .foregroundColor(.white)
        .padding(7)
        .background(Color.red)
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
