//
//  HelpView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//  Tipping from https://www.youtube.com/watch?v=JJG3xI5FmFY

import SwiftUI


struct HelpView: View {
    
    @EnvironmentObject var tipModel : TipModel
    @State var dummy : Bool = false
    //@Binding var expandMain : Bool
    //@Binding var expandTip : Bool
    
    var body: some View {
        
        
        Form {
            
            Section() {
                
                Text(LocalizedStringKey("HelpMessage"))
                
            }
            
            Section() {
                // Share button
                if #available(iOS 16.0, *) {
                    
                    ShareLink(item: URL(string: Constants.URL.appStore)!) {
                        SettingItemView(itemType: "generic", name: "Share", iconBG: .white, iconColour: .black, image: "square.and.arrow.up.fill", showChevron: true, removeSpace : false, toggleBool: $dummy)
                            .foregroundColor(.black)
                    }

                }
                else {
                    Button {
                        
                        guard let urlShare = URL(string: Constants.URL.appStore) else { return }
                        
                        
                        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                        
                        let scenes = UIApplication.shared.connectedScenes
                        let windowScene = scenes.first as? UIWindowScene
                        
                        windowScene?.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
                        
                    } label: {
                        SettingItemView(itemType: "generic", name: "Share", iconBG: .white, iconColour: .black, image: "square.and.arrow.up.fill", showChevron: true, removeSpace : false, toggleBool: $dummy)
                            .foregroundColor(.black)
                            
                    }
                }
                
                // Review
                
                Button {

                    if let url = URL(string: Constants.URL.review) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "generic", name: "Review", iconBG: .orange, iconColour: .white, image: "star.bubble", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }

                
                // GitHub Star Repository
                Button {
                    
                    if let url = URL(string: Constants.URL.sourceCode) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "Star", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                
                Button {
                    
                    if let url = URL(string: Constants.URL.sourceCode) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "HelpTranslate", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, removeSpace : false, toggleBool: $dummy)
                }
                

            }
            
            Section() {
                
                TipView(tips: tipModel.tips)
                
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
            
            
            
            
            

            
            
            
        }
        .navigationTitle(LocalizedStringKey("HelpDev"))
    }
}


