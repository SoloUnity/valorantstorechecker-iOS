//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SkinListView: View {
    
    @EnvironmentObject var model:SkinModel
    
    @State var searchText : String = ""
    @State var selectedFilter : String  = ""
    
    @State var simulatedPricing : Bool = false
    @State var filtered : Bool = false
    @State var selectMelee : Bool = false
    @State var selectOwned : Bool = false
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(spacing: 0){
                
                HStack {
                    SearchBar(text: $searchText)
                        .padding(.trailing, -5)
                    
                    Menu {
                        
                        // MARK: All
                        Button {
                            selectedFilter = ""
                            filtered = false
                        } label: {
                            if selectedFilter == "" {
                                Label("All", systemImage: "checkmark")
                            }
                            else {
                                Text("All")
                            }
                        }
                        
                        // MARK: Owned
                        Button {
                            selectMelee = false
                            selectOwned = true
                            filtered = true
                        } label: {
                            if selectedFilter == "Owned" {
                                Label("Owned", systemImage: "checkmark")
                            }
                            else {
                                Text("Owned")
                            }
                        }
                        
                        // MARK: Knife
                        MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Melee", label: "Knife", selectOwned: $selectOwned)
                        
                        // MARK: Sidearms
                        Menu {
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/BasePistol", label: "Classic", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Slim", label: "Shorty", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/AutoPistol", label: "Frenzy", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Luger", label: "Ghost", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Revolver", label: "Sheriff", selectOwned: $selectOwned)
                            
                            
                        } label: {
                            if selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/BasePistol" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/Slim" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/AutoPistol" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/Luger" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/Revolver" {
                                Label("Sidearm", systemImage: "checkmark")
                            }
                            else {
                                Text("Sidearm")
                            }
                        }
                        
                        // MARK: SMGs
                        Menu {
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/Vector", label: "Stinger", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/MP5", label: "Spectre", selectOwned: $selectOwned)
                            
                            
                        } label: {
                            if selectedFilter == "ShooterGame/Content/Equippables/Guns/SubMachineGuns/Vector" || selectedFilter == "ShooterGame/Content/Equippables/Guns/SubMachineGuns/MP5" {
                                Label("SMGs", systemImage: "checkmark")
                            }
                            else {
                                Text("SMGs")
                            }
                        }
                        
                        // MARK: Shotguns
                        
                        Menu {
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/PumpShotgun", label: "Bucky", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/AutoShotgun", label: "Judge", selectOwned: $selectOwned)
                            
                            
                        } label: {
                            if selectedFilter == "ShooterGame/Content/Equippables/Guns/Shotguns/PumpShotgun" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Shotguns/AutoShotgun" {
                                Label("Shotguns", systemImage: "checkmark")
                            }
                            else {
                                Text("Shotguns")
                            }
                        }
                        
                        // MARK: Rifles
                        Menu {
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Burst", label: "Bulldog", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/DMR", label: "Guardian", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Carbine", label: "Phantom", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/AK", label: "Vandal", selectOwned: $selectOwned)
                            
                            
                            
                        } label: {
                            if selectedFilter == "ShooterGame/Content/Equippables/Guns/Rifles/Burst" || selectedFilter == "ShooterGame/Content/Equippables/Guns/SniperRifles/DMR" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Rifles/Carbine" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Rifles/AK" {
                                Label("Rifles", systemImage: "checkmark")
                            }
                            else {
                                Text("Rifles")
                            }
                        }
                        
                        // MARK: Sniper
                        
                        Menu {
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Leversniper", label: "Marshal", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Boltsniper", label: "Operator", selectOwned: $selectOwned)
                            
                            
                        } label: {
                            if selectedFilter == "ShooterGame/Content/Equippables/Guns/SniperRifles/Leversniper" || selectedFilter == "ShooterGame/Content/Equippables/Guns/SniperRifles/Boltsniper" {
                                Label("Sniper", systemImage: "checkmark")
                            }
                            else {
                                Text("Sniper")
                            }
                        }
                        
                        // MARK: Heavy
                        
                        Menu {
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG", label: "Ares", selectOwned: $selectOwned)
                            
                            MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG", label: "Odin", selectOwned: $selectOwned)
                            
                            
                        } label: {
                            if selectedFilter == "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG" || selectedFilter == "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG" {
                                Label("Heavy", systemImage: "checkmark")
                            }
                            else {
                                Text("Heavy")
                            }
                        }
                        
                        
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .resizable()
                            .scaledToFit()
                            .opacity(filtered ? 1 : 0.5)
                            .padding(.trailing, 5)
                            .frame(height: (UIScreen.main.bounds.height / 40) )
                        
                    }
                    
                    
                    Spacer()
                }
                
                
                ScrollViewReader{ (proxy: ScrollViewProxy) in
                    ScrollView {
                        
                        if model.data.isEmpty{
                            ProgressView()
                        }
                        else{
                            
                            // MARK: Search
                            
                            
                            // A foolproof but braindead method to get knife skins
                            let search = model.data.filter({ searchText.isEmpty ? true : $0.displayName.lowercased().contains(searchText.lowercased())}).filter({selectedFilter.isEmpty ? true : $0.assetPath!.lowercased().contains(selectedFilter.lowercased())})
                            
                            LazyVStack(spacing: 11){
                                
                                ForEach(search){ skin in
                                    
                                    SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                        .frame(height: (UIScreen.main.bounds.height / 6.5))
                                    
                                    
                                }
                                
                                // MARK: Scroll to top button
                                if search.count > 5{
                                    Button {
                                        // Scroll to top
                                        withAnimation { proxy.scrollTo("top", anchor: .top) }
                                        
                                    } label: {
                                        
                                        HStack{
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.up")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(15)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                        .frame(maxHeight: 50)
                                        .background(Blur(radius: 25, opaque: true))
                                        .cornerRadius(10)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: 3)
                                                .offset(y: -1)
                                                .offset(x: -1)
                                                .blendMode(.overlay)
                                                .blur(radius: 0)
                                                .mask {
                                                    RoundedRectangle(cornerRadius: 10)
                                                }
                                        }
                                    }
                                }
                                
                                if search.count == 0 {
                                    
                                    VStack {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(minWidth: 0, maxWidth: 100)
                                            .foregroundColor(.white)
                                        
                                        Text("No skins match your search")
                                    }
                                    .padding(.top, (UIScreen.main.bounds.height / 4))
                                    .opacity(0.5)
                                    
                                    
                                }
                                
                                
                            }
                            .padding(10)
                            .id("top") // Id to identify the top for scrolling
                            .tag("top") // Tag to identify the top for scrolling
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                }
                
                
            }
            .padding(10)
            
        }
    }
    
    // Menu Item
    struct MenuItem: View {
        
        @Binding var selectedFilter : String
        @Binding var filtered : Bool
        var filter : String
        var label : String
        @Binding var selectOwned : Bool
        
        
        
        
        var body: some View {
            Button {
                selectedFilter = filter
                selectOwned = false
                filtered = true
            } label: {
                if selectedFilter == filter {
                    Label(label, systemImage: "checkmark")
                }
                else {
                    Text(label)
                }
            }
            
        }
        
    }
    
}

struct SkinListView_Previews: PreviewProvider {
    static var previews: some View {
        SkinListView()
    }
}

