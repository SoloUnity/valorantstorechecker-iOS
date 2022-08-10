//
//  SupportView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(LocalizedStringKey("Support"))
                    .bold()
                    .font(.title3)
                
                HStack{
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                    
                    Button {
                        if let url = URL(string: Constants.URL.supportTicket) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(LocalizedStringKey("Create"))
                            .bold()
                        
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(.trailing)
                    }
                    
                }
                
                HStack{
                    Image(systemName: "list.bullet.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                    
                    Button {
                        if let url = URL(string: Constants.URL.faq) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(LocalizedStringKey("FAQ"))
                            .bold()
                        
                        
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(.trailing)
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
                        Text(LocalizedStringKey("SourceCode"))
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
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
