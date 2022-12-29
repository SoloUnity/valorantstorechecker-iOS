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
                        SettingItemView(itemType: "generic", name: "Share", iconBG: .white, iconColour: .black, image: "square.and.arrow.up", showChevron: true, toggleBool: $dummy)
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
                        SettingItemView(itemType: "generic", name: "Share", iconBG: .white, iconColour: .black, image: "square.and.arrow.up", showChevron: true, toggleBool: $dummy)
                            .foregroundColor(.black)
                            
                    }
                }
                
                // Review
                
                Button {

                    if let url = URL(string: Constants.URL.review) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "generic", name: "Review", iconBG: .white, iconColour: .orange, image: "star.bubble", showChevron: true, toggleBool: $dummy)
                }

                
                // GitHub Star Repository
                Button {
                    
                    if let url = URL(string: Constants.URL.sourceCode) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "Star", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, toggleBool: $dummy)
                }
                
                Button {
                    
                    if let url = URL(string: Constants.URL.sourceCode) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    SettingItemView(itemType: "custom", name: "HelpTranslate", iconBG: .cyan, iconColour: .white, image: "github", showChevron: true, toggleBool: $dummy)
                }
                

            }
            
            Section() {
                
                TipView(tips: tipModel.tips)
                
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
            
            
            
            
            

            
            
            
        }
        .navigationTitle("Help the Dev!")
         
        /*
        HStack{
            VStack(alignment: .leading, spacing: 20){
                
                Button {
                    
                    expandMain.toggle()
                    
                } label: {
                    
                    HStack{
                        
                        Text(LocalizedStringKey("Help"))
                            .bold()
                            .font(.title3)
                            
                        Spacer()
                        
                        Image(systemName: expandMain ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 6)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    
                }
                
                if expandMain {
                    
                    Text(LocalizedStringKey("HelpMessage"))
                        .font(.footnote)
                    
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            
                            guard let urlShare = URL(string: Constants.URL.appStore) else { return }
                            
                            
                            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                            
                            let scenes = UIApplication.shared.connectedScenes
                            let windowScene = scenes.first as? UIWindowScene
                            
                            windowScene?.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
                            
                            
                        } label: {
                            
                            LinkImage()
                            
                            Text(LocalizedStringKey("Share"))
                                .bold()
                            
                            
                            
                        }
                        
                    }
                    
                    HStack{
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            
                            guard let writeReviewURL = URL(string: Constants.URL.review)
                                else { fatalError("Expected a valid URL") }
                            UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
                            
                        } label: {
                            LinkImage()
                            
                            Text(LocalizedStringKey("Review"))
                                .bold()
                            
                            
                            
                        }
                        
                    }
                    
                    HStack{
                        Image("github")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            if let url = URL(string: Constants.URL.sourceCode) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            LinkImage()
                            
                            Text("Star")
                                .bold()
                            
                        }
                        
                    }
                    
                    HStack{
                        Image("github")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            if let url = URL(string: Constants.URL.sourceCode) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            LinkImage()
                            
                            Text("HelpTranslate")
                                .bold()
                            
                        }
                        
                    }
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        
                        TipView(expand: $expandTip, tips: tipModel.tips)
                        
                        Spacer()
                        
                    }
                    
                }
                
            }
            .animation(.spring(), value: expandMain)
            
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
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
        .animation(.spring(), value: expandTip)
         */
        
        
         
    }
    

}


