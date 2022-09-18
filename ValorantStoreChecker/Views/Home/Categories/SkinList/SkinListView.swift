//
//  SkinListView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-18.
//

import SwiftUI

struct SkinListView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    @State var searchText : String = ""
    @State var selectedFilter : String  = ""
    
    @State var simulatedPricing : Bool = false
    @State var filtered : Bool = false
    @State var selectOwned : Bool = false
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(spacing: 0){
                
                ScrollViewReader{ (proxy: ScrollViewProxy) in
                    HStack {
                        SearchBar(text: $searchText)
                            .onChange(of: searchText) { newValue in
                                proxy.scrollTo("top", anchor: .top)
                            }
                            .padding(.trailing, -5)
                            
                        
                        Menu {
                            
                            // MARK: All
                            Button {
                                selectedFilter = ""
                                selectOwned = false
                                filtered = false
                                proxy.scrollTo("top", anchor: .top)
                            } label: {
                                if selectedFilter == "" && !selectOwned {
                                    Label(LocalizedStringKey("All"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("All"))
                                }
                            }
                            
                            // MARK: Owned
                            Button {
                                selectOwned = true
                                filtered = true
                                selectedFilter = ""
                                proxy.scrollTo("top", anchor: .top)
                            } label: {
                                if selectOwned {
                                    Label(LocalizedStringKey("Owned"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Owned"))
                                }
                            }
                            
                            // MARK: Knife
                            
                            Button {
                                selectedFilter = "ShooterGame/Content/Equippables/Melee"
                                selectOwned = false
                                filtered = true
                                proxy.scrollTo("top", anchor: .top)
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Melee" {
                                    Label(LocalizedStringKey("Knife"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Knife"))
                                }
                            }
                            
                            // MARK: Sidearms
                            Menu {
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/BasePistol", label: "Classic", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Slim", label: "Shorty", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/AutoPistol", label: "Frenzy", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Luger", label: "Ghost", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Revolver", label: "Sheriff", selectOwned: $selectOwned, proxy: proxy)
                                
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/BasePistol" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/Slim" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/AutoPistol" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/Luger" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Sidearms/Revolver" {
                                    Label(LocalizedStringKey("Sidearm"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Sidearm"))
                                }
                            }
                            
                            // MARK: SMGs
                            Menu {
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/Vector", label: "Stinger", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/MP5", label: "Spectre", selectOwned: $selectOwned, proxy: proxy)
                                
                                
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Guns/SubMachineGuns/Vector" || selectedFilter == "ShooterGame/Content/Equippables/Guns/SubMachineGuns/MP5" {
                                    Label(LocalizedStringKey("SMGs"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("SMGs"))
                                }
                            }
                            
                            // MARK: Shotguns
                            
                            Menu {
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/PumpShotgun", label: "Bucky", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/AutoShotgun", label: "Judge", selectOwned: $selectOwned, proxy: proxy)
                                
                                
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Guns/Shotguns/PumpShotgun" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Shotguns/AutoShotgun" {
                                    Label(LocalizedStringKey("Shotguns"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Shotguns"))
                                }
                            }
                            
                            // MARK: Rifles
                            Menu {
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Burst", label: "Bulldog", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/DMR", label: "Guardian", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Carbine", label: "Phantom", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/AK", label: "Vandal", selectOwned: $selectOwned, proxy: proxy)
                                
                                
                                
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Guns/Rifles/Burst" || selectedFilter == "ShooterGame/Content/Equippables/Guns/SniperRifles/DMR" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Rifles/Carbine" || selectedFilter == "ShooterGame/Content/Equippables/Guns/Rifles/AK" {
                                    Label(LocalizedStringKey("Rifles"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Rifles"))
                                }
                            }
                            
                            // MARK: Sniper
                            
                            Menu {
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Leversniper", label: "Marshal", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Boltsniper", label: "Operator", selectOwned: $selectOwned, proxy: proxy)
                                
                                
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Guns/SniperRifles/Leversniper" || selectedFilter == "ShooterGame/Content/Equippables/Guns/SniperRifles/Boltsniper" {
                                    Label(LocalizedStringKey("Sniper"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Sniper"))
                                }
                            }
                            
                            // MARK: Heavy
                            
                            Menu {
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG", label: "Ares", selectOwned: $selectOwned, proxy: proxy)
                                
                                MenuItem(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG", label: "Odin", selectOwned: $selectOwned, proxy: proxy)
                                
                                
                            } label: {
                                if selectedFilter == "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG" || selectedFilter == "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG" {
                                    Label(LocalizedStringKey("Heavy"), systemImage: "checkmark")
                                }
                                else {
                                    Text(LocalizedStringKey("Heavy"))
                                }
                            }
                            
                            
                            
                        } label: {
                            // MARK: Menu label
                            
                            Image(systemName: filtered ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle" )
                                .resizable()
                                .scaledToFit()
                                .opacity(filtered ? 0.8 : 0.4)
                                .padding(.trailing, 5)
                                .frame(height: (UIScreen.main.bounds.height / 40) )
                            
                        }
                        
                        
                        Spacer()
                    }
                    
                    ScrollView {
                        
                        
                        
                        if skinModel.data.isEmpty{
                            ProgressView()
                        }
                        else{
                            
                            // MARK: Search
                            
                            
                            // A foolproof but braindead method to get knife skins
                            let search = skinModel.data.filter({ searchText.isEmpty ? true : $0.displayName.lowercased().contains(searchText.lowercased())}).filter({selectedFilter.isEmpty ? true : $0.assetPath!.lowercased().contains(selectedFilter.lowercased())}).filter { one in
                                selectOwned ? authAPIModel.owned.contains { two in
                                    one.displayName == two
                                } : true
                            }
                            
                            
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
                                
                                // MARK: No search item button
                                
                                if search.count == 0 {
                                    
                                    VStack {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(minWidth: 0, maxWidth: 100)
                                            .foregroundColor(.white)
                                        
                                        Text(selectOwned ? LocalizedStringKey("NoOwned") : LocalizedStringKey("EmptySearch"))
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
    
    // MARK: Menu Item
    struct MenuItem: View {
        
        @Binding var selectedFilter : String
        @Binding var filtered : Bool
        var filter : String
        var label : String
        @Binding var selectOwned : Bool
        var proxy : ScrollViewProxy
        
        var body: some View {
            Button {
                selectedFilter = filter
                selectOwned = false
                filtered = true
                proxy.scrollTo("top", anchor: .top)
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

