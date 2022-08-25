//
//  SpecialView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-18.
//

import SwiftUI

struct BundleView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                
                ScrollViewReader{ (proxy: ScrollViewProxy) in
    
                    Logo()
                        .frame(width: geo.size.width/6.5)
                    
                    ScrollView(showsIndicators: false) {
                        
                        PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                            Task{
                                await authAPIModel.reload()
                            }
                        }
                        
                        
                        if authAPIModel.bundle.isEmpty{
                            
                            VStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 100)
                                    .foregroundColor(.white)
                                
                                Text( LocalizedStringKey("EmptyBundle"))
                            }
                            .padding(.top, (UIScreen.main.bounds.height / 4))
                            .opacity(0.5)
                            
                            
                        }
                        else{
                            
                            
                            LazyVStack(spacing: 11){
                                
                                ShopTopBarView(referenceDate: defaults.object(forKey: "bundleTimeLeft") as? Date ?? Date())
                                
                                BundleImageView()
                                
                                ForEach(authAPIModel.bundle) { skin in
                                    
                                    SkinCardView(skin: skin, showPrice: true, showPriceTier: true)
                                        .frame(height: (UIScreen.main.bounds.height / 6.5))
                                    
                                }
                                
                                if authAPIModel.bundle.count > 3 {
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
                                
                                
                                
                            }
                            .padding(10)
                            .id("top") // Id to identify the top for scrolling
                            .tag("top") // Tag to identify the top for scrolling
                            
                        }
                    }
                    .coordinateSpace(name: "pullToRefresh")
                    .onAppear{
                        proxy.scrollTo("top", anchor: .top)
                    }
                }
            }
            .padding(10)
            
        }
        
        
    }
}


