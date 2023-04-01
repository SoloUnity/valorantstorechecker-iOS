//
//  FilterView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    @EnvironmentObject var networkModel : NetworkModel
    

    @Binding var priceSort : String
    @Binding var selectedFilter : String
    @Binding var selectOwned : Bool
    @Binding var filterName : String
    @Binding var hasScrolled : Bool
    var proxy : ScrollViewProxy
    
    
    var body: some View {
        Menu {
   
            // MARK: Owned
            Button {
                
                selectOwned.toggle()
                proxy.scrollTo("top", anchor: .top)
                
                if networkModel.isConnected {
                    Task{
                        await authAPIModel.reload(skinModel: skinModel, reloadType: "ownedReload")
                    }
                }

                
            } label: {
                if selectOwned {
                    Label(LocalizedStringKey("Owned"), systemImage: "checkmark")
                }
                else {
                    Text(LocalizedStringKey("Owned"))
                }
            }
            
            Divider()
            
            Button {
                
                priceSort = ""
                
            } label: {
                if priceSort == "" {
                    Label(LocalizedStringKey("A→Z"), systemImage: "checkmark")
                }
                else {
                    Text(LocalizedStringKey("A→Z"))
                }
            }
            
            Menu {
                Button {
                    priceSort = "ascending"
                    proxy.scrollTo("top", anchor: .top)
                } label: {
                    if priceSort == "ascending" {
                        Label(LocalizedStringKey("LowestFirst"), systemImage: "checkmark")
                    }
                    else {
                        Text(LocalizedStringKey("LowestFirst"))
                    }
                }
                
                Button {
                    priceSort = "descending"
                    proxy.scrollTo("top", anchor: .top)
                } label: {
                    if priceSort == "descending" {
                        Label(LocalizedStringKey("HighestFirst"), systemImage: "checkmark")
                    }
                    else {
                        Text(LocalizedStringKey("HighestFirst"))
                    }
                }
            }
            label : {
                if priceSort != "" {
                    Label(LocalizedStringKey("PriceSort"), systemImage: "checkmark")
                }
                else {
                    Text(LocalizedStringKey("PriceSort"))
                }
            }
            
            Divider()
            
            
            // MARK: All
            Group {
                Button {
                    selectedFilter = ""
                    filterName = ""
                    proxy.scrollTo("top", anchor: .top)
                } label: {
                    if selectedFilter == "" {
                        Label(LocalizedStringKey("All"), systemImage: "checkmark")
                    }
                    else {
                        Text(LocalizedStringKey("All"))
                    }
                }
                
                // MARK: Knife
                
                Button {
                    selectedFilter = "ShooterGame/Content/Equippables/Melee"
                    filterName = "Knife"
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
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/BasePistol", label: "Classic", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Slim", label: "Shorty", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/AutoPistol", label: "Frenzy", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Luger", label: "Ghost", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Revolver", label: "Sheriff", selectOwned: $selectOwned, proxy: proxy)
                    
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
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/Vector", label: "Stinger", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/MP5", label: "Spectre", selectOwned: $selectOwned, proxy: proxy)
                    
                    
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
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/PumpShotgun", label: "Bucky", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/AutoShotgun", label: "Judge", selectOwned: $selectOwned, proxy: proxy)
                    
                    
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
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Burst", label: "Bulldog", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/DMR", label: "Guardian", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Carbine", label: "Phantom", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/Rifles/AK", label: "Vandal", selectOwned: $selectOwned, proxy: proxy)
                    
                    
                    
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
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Leversniper", label: "Marshal", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Boltsniper", label: "Operator", selectOwned: $selectOwned, proxy: proxy)
                    
                    
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
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG", label: "Ares", selectOwned: $selectOwned, proxy: proxy)
                    
                    MenuItemView(selectedFilter: $selectedFilter, filterName: $filterName, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG", label: "Odin", selectOwned: $selectOwned, proxy: proxy)
                    
                    
                } label: {
                    if selectedFilter == "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG" || selectedFilter == "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG" {
                        Label(LocalizedStringKey("Heavy"), systemImage: "checkmark")
                    }
                    else {
                        Text(LocalizedStringKey("Heavy"))
                    }
                }
            }
            
            
        } label: {
            // MARK: Menu label
            
            if !selectOwned && selectedFilter == "" && priceSort == "" {
                Image(systemName: "line.3.horizontal.decrease.circle" )
                    .padding(.vertical, hasScrolled ? 2 : 12)
                    .padding(.horizontal, 8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20 , style: .continuous))
                    .animation(.spring(response: 0.55, dampingFraction: 0.9), value: hasScrolled)
            }
            else {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .padding(.vertical, hasScrolled ? 2 : 12)
                    .padding(.horizontal, 8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20 , style: .continuous))
                    .animation(.spring(response: 0.55, dampingFraction: 0.9), value: hasScrolled)
            }
            
        }
    }
}
