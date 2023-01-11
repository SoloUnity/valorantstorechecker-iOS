//
//  SettingItemView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI



struct SettingItemView: View {
    
    @Environment(\.colorScheme) var colourScheme
    @AppStorage("dark") var toggleDark = true
    @AppStorage("autoDark") var auto = false
    
    var itemType : String
    var name : String
    var iconBG : Color
    var iconColour : Color
    var image: String
    var defaultName : String = ""
    var showChevron : Bool = false
    var removeSpace : Bool = true
    @Binding var toggleBool : Bool
    
    
    
    let defaults = UserDefaults.standard
    
    
    var body: some View {
        
        ZStack {
            HStack {
                if itemType == "generic" {
                    if !(iconBG == .white) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .foregroundColor(iconBG)
                            Image(systemName: image)
                                .foregroundColor(iconColour)
                        }
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing)
                        
                        Text(LocalizedStringKey(name))
                            .foregroundColor(auto ? (colourScheme == .light ? .black : .white) : (toggleDark ? .white : .black))
                        
                    }
                    else {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.3)
                                .background(.white)
                                .cornerRadius(8)
                            
                            Image(systemName: image)
                                .foregroundColor(iconColour)
                            
                        }
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing)
                        
                        Text(LocalizedStringKey(name))
                            .foregroundColor(auto ? (colourScheme == .light ? .black : .white) : (toggleDark ? .white : .black))
                    }
                }
                else if itemType == "custom" {
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(iconBG)
                        
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23, height: 23, alignment: .center)
                            .foregroundColor(iconColour)

                    }
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.trailing)
                    
                    Text(LocalizedStringKey(name))
                        .foregroundColor(auto ? (colourScheme == .light ? .black : .white) : (toggleDark ? .white : .black))
                    
                }
                else if itemType == "toggle" {
                    HStack {
                        // MARK: Toggle
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(iconBG)
                            Image(systemName: image)
                                .foregroundColor(iconColour)
                        }
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing)
                        
                        Spacer()
                        
                        
                        Toggle(LocalizedStringKey(name), isOn: $toggleBool)
                            .onAppear {
                                
                                if defaults.bool(forKey: defaultName) {
                                    self.toggleBool = true
                                }
                                
                            }
                    }
                    
                    
                }
                
                if !removeSpace {
                    Spacer()
                }
                
                
            }
            
            if showChevron {
                
                HStack {
                    Spacer()
                    
                    ChevronView()
                }
                
            }
            
        }
        
        
        
        
        
        
        
    }
}


