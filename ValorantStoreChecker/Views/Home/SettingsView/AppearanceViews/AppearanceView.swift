//
//  AppearanceView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-23.
//  https://www.youtube.com/watch?v=cbJuWtGOjs4

import SwiftUI

struct AppearanceView: View {
    
    @AppStorage("systemTheme") var systemTheme : Int = 0
    @State var showUpdate = true
    @State var colourScheme = 0
    @State var dummy = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        Form {
            
            Section() {
                
                SettingItemView(itemType: "toggle", name: "Alert for New Updates", iconBG: .pink, iconColour: .white, image: "chevron.up.circle.fill", defaultName: "showUpdate", toggleBool: $showUpdate)
                    .onChange(of: showUpdate) { boolean in
                        
                        
                        if boolean {
                            defaults.set(boolean, forKey: "showUpdate")
                        }
                        else {
                            defaults.removeObject(forKey: "showUpdate")
                        }
                    }

                HStack{
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.25)
                            .background(.white)
                            .cornerRadius(8)
                        
                        Image(systemName: "circle.lefthalf.filled")
                            .foregroundColor(.black)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.trailing)
                    
                    Spacer()

                    Picker("Colour Scheme", selection: $colourScheme){
                        
                        Text(LocalizedStringKey("Auto"))
                            .tag(0)
                        
                        Text(LocalizedStringKey("Light"))
                            .tag(1)
                        
                        Text(LocalizedStringKey("Dark"))
                            .tag(2)
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: colourScheme) { colour in
                        if colour == 0 {
                            defaults.set(false, forKey: "dark")
                            defaults.set(true, forKey: "autoDark")
                            
                        }
                        else if colour == 1 {
                            defaults.set(false, forKey: "autoDark")
                            defaults.set(false, forKey: "dark")
                            
                        }
                        else if colour == 2 {
                            defaults.set(false, forKey: "autoDark")
                            defaults.set(true, forKey: "dark")
                            
                        }

                    }

                }
            }
            
            
            
        }
        .navigationTitle("Appearance")
        .onAppear {
            if defaults.bool(forKey: "autoDark") {
                self.colourScheme = 0
            }
            else if !defaults.bool(forKey: "dark") {
                self.colourScheme = 1
            }
            else {
                self.colourScheme = 2
            }
        }
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
    }
}
