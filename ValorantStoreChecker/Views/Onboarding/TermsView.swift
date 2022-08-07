//
//  TermsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        ScrollView{
            
            LazyVStack(alignment: .leading) {
                Text(LocalizedStringKey("TermsAndConditions"))
                    .font(.title)
                    .padding(.bottom)
                
                Text(LocalizedStringKey("MITLicense \n"))

                Text(LocalizedStringKey("CopyrightGordon \n"))

                Text(LocalizedStringKey("Paragraph1 \n"))
                
                Text(LocalizedStringKey("Paragraph2 \n"))

                Text(LocalizedStringKey("CopyrightNotice"))
                
                Button {
                    if let url = URL(string: "https://lunacnet.notion.site/lunacnet/Valorant-Store-Chcecker-ce4ed87caebb4fbc94e1af3debb5b7b8") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text(LocalizedStringKey("AdditionalInformation"))
                        .bold()
                    
                    
                    Image(systemName: "link")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(.trailing)
                }
                
            }
            .padding()
            
        }
        .background(Constants.bgGrey)
        
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
