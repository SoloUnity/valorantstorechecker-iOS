//
//  CopyrightView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct CopyrightView: View {
    
    @State var showTerms = false
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(LocalizedStringKey("Copyright"))
                    .bold()
                    .font(.title3)
                
                
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
                        
                        Text(LocalizedStringKey("TermsAndConditions"))
                            .bold()
                        
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(.trailing)
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
                        
                        Text(LocalizedStringKey("Privacy"))
                            .bold()
                        
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(.trailing)
                    }
                    
                }
                
                
                
                
            }
            
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

struct CopyrightView_Previews: PreviewProvider {
    static var previews: some View {
        CopyrightView()
    }
}
