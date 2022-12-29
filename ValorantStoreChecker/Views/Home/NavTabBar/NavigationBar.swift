//
//  NavigationBar.swift
//  JPDesignCode_iOS15
//
//  Created by 周健平 on 2022/6/8.
//

import SwiftUI

struct NavigationBar: View {
    
    @AppStorage("selectedTab") var selectedTab: Tab = .shop
    @AppStorage("nightMarket") var nightMarket : Bool = false
    var title: String = ""
    @Binding var hasScrolled: Bool
    
    var body: some View {
        ZStack {
            
            Color.clear
                .background(.ultraThinMaterial)
                .opacity(hasScrolled ? 1 : 0)
            
                
            
            
            HStack {

                Logo()
                    .padding(hasScrolled ? 0 : 6)
                

                Text(LocalizedStringKey(title))
                    .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                
                
                Spacer()
                
                if selectedTab == .nightMarket {
                    
                    Image(systemName: "moon.stars.fill" )
                        .padding(.vertical, hasScrolled ? 2 : 12)
                        .padding(.horizontal, 8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20 , style: .continuous))
                        .foregroundColor(.pink)
                        .animation(.spring(response: 0.55, dampingFraction: 0.9), value: hasScrolled)
                        .onTapGesture{
                            selectedTab = .nightMarket
                            haptic()
                        }
                    
                }
                else {
                    Image(systemName: "moon.stars" )
                        .padding(.vertical, hasScrolled ? 2 : 12)
                        .padding(.horizontal, 8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20 , style: .continuous))
                        .foregroundColor(.gray)
                        .animation(.spring(response: 0.55, dampingFraction: 0.9), value: hasScrolled)
                        .onTapGesture{
                            selectedTab = .nightMarket
                            haptic()
                        }
                }
                 
                
                

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)

            
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(false))
    }
}
