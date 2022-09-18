//
//  TermsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("TermsAndConditions"))
                .font(.title)
                .bold()
                .padding()
                
            
            ScrollView{
                
                
                
                LazyVStack(alignment: .leading) {
                    
                    
                    Text(LocalizedStringKey("MITLicense"))

                    Text(LocalizedStringKey("CopyrightGordon"))

                    Text(LocalizedStringKey("Paragraph1"))
                    
                    Text(LocalizedStringKey("Paragraph2"))

                    Text(LocalizedStringKey("CopyrightNotice"))
                    
                    Button {
                        if let url = URL(string: "https://solounity.notion.site/solounity/Valorant-Store-Checker-App-Privacy-Policy-761932ab3fcb4fea95564b2b63d2d5b5") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        
                        LinkImage()
                        
                        Text(LocalizedStringKey("Privacy"))
                            .bold()
                        
                        
                    }
                    
                }
                .padding()
                
            }
            .background(Constants.bgGrey)
        }
        
        
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
