//
//  AppearanceView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-23.
//  https://www.youtube.com/watch?v=cbJuWtGOjs4

import SwiftUI

struct AppearanceView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("systemTheme") var systemTheme : Int = 0
    @AppStorage("activeIcon") var activeIcon : String = "AppIcon 4"
    @AppStorage("dark") var toggleDark = false
    @AppStorage("autoDark") var auto = false
    @AppStorage("background") var background = "Background 3"
    @AppStorage("showUpdate") var showUpdate = true
    @State var colourScheme = 0
    @State var dummy = false
    
    let defaults = UserDefaults.standard
    let customIcons : [String] = ["AppIcon 4", "AppIcon 1", "AppIcon 2", "AppIcon 3"]
    
    var body: some View {
        Form {
            
            Section() {
                
                SettingItemView(itemType: "toggle", name: "CheckUpdates", iconBG: .pink, iconColour: .white, image: "chevron.up.circle.fill", defaultName: "showUpdate", toggleBool: $showUpdate)


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
                    
                    Text("ColourScheme")
                    
                    Spacer()

                    
                    //LOCALIZETEXT
                    Picker("", selection: $colourScheme){
                        
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
                    
                    if #available(iOS 16, *) {
                        // code that should only run on iOS 16 and above
                    } else {
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.pink)
                    }
                }
            }
            
            //LOCALIZETEXT
            Section(header: Text("Background")) {
                HStack {

                    
                    VStack {
                        
                        Rectangle()
                            .foregroundColor(auto ? (colorScheme == .light ? .white : .black) : (toggleDark ? .black : .white))
                            .cornerRadius(10)
                            .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                            .shadow(color: .gray, radius: 1)
                            .padding(.bottom)
                        
                        
                        
                        if background == "" {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.pink)
                        }
                        else {
                            Image(systemName: "circle")
                                .foregroundColor(.pink)
                        }
                        
                    }
                    .onTapGesture {
                        self.background = ""
                    }
                    
                    VStack {
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(auto ? (colorScheme == .light ? .white : .black) : (toggleDark ? .black : .white))
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                                .shadow(color: .gray, radius: 1)
                            
                            Image("Background 1")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                        }
                        .padding(.bottom)
                        

                        if background == "Background 1" {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.pink)
                        }
                        else {
                            Image(systemName: "circle")
                                .foregroundColor(.pink)
                        }
                    }
                    .onTapGesture {
                        self.background = "Background 1"
                    }
                    
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(auto ? (colorScheme == .light ? .white : .black) : (toggleDark ? .black : .white))
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                                .shadow(color: .gray, radius: 1)
                            
                            Image("Background 2")
                                .resizable()
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                                .scaledToFill()
                                .cornerRadius(10)
                        }
                        .padding(.bottom)

                        
                        if background == "Background 2" {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.pink)
                        }
                        else {
                            Image(systemName: "circle")
                                .foregroundColor(.pink)
                        }
                    }
                    .onTapGesture{
                        self.background = "Background 2"
                    }

                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(auto ? (colorScheme == .light ? .white : .black) : (toggleDark ? .black : .white))
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                                .shadow(color: .gray, radius: 1)
                            
                            Image("Background 3")
                                .resizable()
                                .aspectRatio(CGSize(width: 9, height: 16), contentMode: .fit)
                                .scaledToFill()
                                .cornerRadius(10)
                                
                        }
                        .padding(.bottom)

                        
                        if background == "Background 3" {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.pink)
                        }
                        else {
                            Image(systemName: "circle")
                                .foregroundColor(.pink)
                        }
                    }
                    .onTapGesture{
                        self.background = "Background 3"
                    }

                    
                }
                .padding(10)
                
            }
            
            //LOCALIZETEXT
            Section(header: Text(LocalizedStringKey("AppIcon"))) {
                
                ForEach(customIcons, id: \.self) { icon in
                    
                    Button {
                        
                        // Set the alternate app icon
                        UIApplication.shared.setAlternateIconName(icon)
                        activeIcon = icon
                        
                    } label: {
                        HStack {
                            
                            Image(String(icon + " Preview"))
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 75, maxHeight: 75)
                                .shadow(color: .gray, radius: 1)
                                .padding(.trailing)
                            
                            // LOCALIZETEXT
                            HStack {
                                if icon == "AppIcon 4" {
                                    Text("DefaultDark")
                                }
                                else if icon == "AppIcon 1" {
                                    Text("3DDark")
                                }
                                else if icon == "AppIcon 2" {
                                    Text("DefaultLight")
                                }
                                else if icon == "AppIcon 3" {
                                    Text("3DLight")
                                }
                            }
                            .foregroundColor(auto ? (colorScheme == .light ? .black : .white) : (toggleDark ? .white : .black))
                            
                            
                            Spacer()
                            
                            if activeIcon == icon {
                                Image(systemName: "checkmark")
                            }
                                                    
                        }
                    }

                    
                }
                
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
            
            
        }
        .navigationTitle("Appearance")
        .onAppear {
            if auto {
                self.colourScheme = 0
            }
            else if !toggleDark {
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
