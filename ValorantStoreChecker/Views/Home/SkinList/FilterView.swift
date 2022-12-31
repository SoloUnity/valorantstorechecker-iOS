//
//  FilterView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var selectedFilter : String
    @Binding var selectOwned : Bool
    @Binding var filtered : Bool
    @Binding var hasScrolled : Bool
    var proxy : ScrollViewProxy
    
    
    var body: some View {
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
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/BasePistol", label: "Classic", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Slim", label: "Shorty", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/AutoPistol", label: "Frenzy", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Luger", label: "Ghost", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Sidearms/Revolver", label: "Sheriff", selectOwned: $selectOwned, proxy: proxy)
                
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
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/Vector", label: "Stinger", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SubMachineGuns/MP5", label: "Spectre", selectOwned: $selectOwned, proxy: proxy)
                
                
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
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/PumpShotgun", label: "Bucky", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Shotguns/AutoShotgun", label: "Judge", selectOwned: $selectOwned, proxy: proxy)
                
                
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
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Burst", label: "Bulldog", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/DMR", label: "Guardian", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/Carbine", label: "Phantom", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/Rifles/AK", label: "Vandal", selectOwned: $selectOwned, proxy: proxy)
                
                
                
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
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Leversniper", label: "Marshal", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/SniperRifles/Boltsniper", label: "Operator", selectOwned: $selectOwned, proxy: proxy)
                
                
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
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/LMG", label: "Ares", selectOwned: $selectOwned, proxy: proxy)
                
                MenuItemView(selectedFilter: $selectedFilter, filtered: $filtered, filter: "ShooterGame/Content/Equippables/Guns/HvyMachineGuns/HMG", label: "Odin", selectOwned: $selectOwned, proxy: proxy)
                
                
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
                .padding(.vertical, hasScrolled ? 2 : 12)
                .padding(.horizontal, 8)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20 , style: .continuous))
                .animation(.spring(response: 0.55, dampingFraction: 0.9), value: hasScrolled)
            
        }
    }
}

