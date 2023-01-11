//
//  HomeView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-12-16.
//

import SwiftUI

enum Tab: String {
    case shop
    case bundle
    case skinList
    case settings
    case nightMarket
}

struct TabItem: Identifiable {
    let id = UUID()
    let text: String
    let icon: String
    let tab: Tab
}

let tabItems = [
    TabItem(text: "Store", icon: "cart", tab: .shop),
    TabItem(text: "Bundle", icon: "archivebox.fill", tab: .bundle),
    TabItem(text: "SkinIndex", icon: "list.bullet", tab: .skinList),
    TabItem(text: "Settings", icon: "gear", tab: .settings),
    TabItem(text: "NightMarket", icon: "moon.stars", tab: .nightMarket)
]
