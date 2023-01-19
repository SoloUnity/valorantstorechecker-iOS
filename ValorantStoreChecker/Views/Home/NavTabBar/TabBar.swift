//
//  TabBar.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct TabBar: View {
    
    @EnvironmentObject var updateModel : UpdateModel
    @AppStorage("selectedTab") var selectedTab: Tab = .shop
    @State var tabItemWidth: CGFloat = 0
    
    var diffSafeAreaBottomInset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { proxy in

            let hasHomeIndicator = (proxy.safeAreaInsets.bottom - diffSafeAreaBottomInset) > 20
            
            HStack {
                buttons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 88 : 60, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 34 : 0, style: .continuous))
            .background(background)
            .overlay(overlay)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
        
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                
                selectedTab = item.tab
                
            } label: {
                
                if item.tab != .nightMarket {
                    VStack(spacing: 0) {
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 44, height: 29)
                        Text(LocalizedStringKey(item.text))
                            .font(.caption2)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .foregroundStyle(
                selectedTab == item.tab ? .primary : .secondary
            )
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay {
                GeometryReader { proxy in

                    Color.clear
                        .preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            }
            .onPreferenceChange(TabPreferenceKey.self) { value in

                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .bundle {
                Spacer()
            }
            if selectedTab == .skinList {
                Spacer()
                Spacer()
            }
            if selectedTab == .settings {
                Spacer()
            }
            
            if selectedTab != .nightMarket {
                Circle()
                    .fill(.pink)
                    .frame(width: tabItemWidth)
            }
            
            
            if selectedTab == .shop {
                Spacer()
            }
            if selectedTab == .bundle {
                Spacer()
                Spacer()
            }
            if selectedTab == .skinList {
                Spacer()
            }
            
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .bundle {
                Spacer()
            }
            if selectedTab == .skinList {
                Spacer()
                Spacer()
            }
            if selectedTab == .settings {
                Spacer()
            }
            
            if selectedTab != .nightMarket {
                Rectangle()
                    .fill(.pink)
                    .frame(width: 28, height: 5)
                    .cornerRadius(3)
                    .frame(width: tabItemWidth)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
           
            
            if selectedTab == .shop {
                Spacer()
            }
            if selectedTab == .bundle {
                Spacer()
                Spacer()
            }
            if selectedTab == .skinList {
                Spacer()
            }
            
        }
        .padding(.horizontal, 8)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
