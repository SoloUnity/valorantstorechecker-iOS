//
//  CommunityView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct CommunityView: View {
    
    @Binding var expand : Bool
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20){
                
                Button {
                    
                    expand.toggle()
                    
                } label: {
                    
                    HStack{
                        
                        Text(LocalizedStringKey("Community"))
                            .bold()
                            .font(.title3)
                            
                        Spacer()
                        
                        Image(systemName: expand ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 6)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    
                }
                
                if expand {
                    
                    HStack{
                        Image(systemName: "globe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            if let url = URL(string: Constants.URL.website) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            
                            LinkImage()
                            
                            Text(LocalizedStringKey("Website"))
                                .bold()
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    HStack{
                        Image("discord")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            if let url = URL(string: Constants.URL.discord) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            LinkImage()
                            
                            Text(LocalizedStringKey("DiscordServer"))
                                .bold()
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            .animation(.spring(), value: expand)

            
            
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
    }
}


