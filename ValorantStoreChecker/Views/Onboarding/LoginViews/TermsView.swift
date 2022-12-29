//
//  TermsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        

        ScrollView(showsIndicators: false){
            
            LazyVStack(alignment: .leading) {
                
                
                Text(LocalizedStringKey("MITLicense"))

                Text(LocalizedStringKey("CopyrightGordon"))

                Text(LocalizedStringKey("Paragraph1"))
                
                Text(LocalizedStringKey("Paragraph2"))

                Text(LocalizedStringKey("CopyrightNotice"))
                
                
            }
            .padding()
            
        }
        .navigationTitle(LocalizedStringKey("TermsAndConditions"))
        
        
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
