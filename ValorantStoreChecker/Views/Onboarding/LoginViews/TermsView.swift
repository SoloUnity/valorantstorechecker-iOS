//
//  TermsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        

        Form {
            Section(header: Text(LocalizedStringKey("TermsAndConditions"))) {
                Text(LocalizedStringKey("MITLicense"))
            }
            
            Section(header: Text(LocalizedStringKey("Copyright"))) {
                Text(LocalizedStringKey("CopyrightNotice"))
            }
            
            Section(header: Text("")) {
                EmptyView()
                
            }
        }
        .navigationTitle(LocalizedStringKey("TermsAndConditions"))
        
        
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
