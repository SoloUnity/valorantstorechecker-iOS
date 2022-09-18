//
//  CopyrightView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct CopyrightView: View {
    
    @Binding var expand : Bool
    @State var showTerms = false
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20){
                
                Button {
                    
                    expand.toggle()
                    
                } label: {
                    
                    HStack{
                        
                        Text(LocalizedStringKey("Copyright"))
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
                    
                    Text(LocalizedStringKey("CopyrightNotice"))
                        .font(.footnote)
                    
                    HStack{
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            
                            self.showTerms = true
                            
                        } label: {
                            
                            LinkImage()
                            
                            Text(LocalizedStringKey("TermsAndConditions"))
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                        }
                        
                    }
                    
                    HStack{
                        Image(systemName: "hand.raised.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            if let url = URL(string: Constants.URL.privacy) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            
                            LinkImage()
                            
                            Text(LocalizedStringKey("Privacy"))
                                .bold()
                                .multilineTextAlignment(.leading)
                            

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
        .sheet(isPresented: $showTerms) {
            TermsView()
                .background(Constants.bgGrey)
                .preferredColorScheme(.dark)
        }
    }
}


