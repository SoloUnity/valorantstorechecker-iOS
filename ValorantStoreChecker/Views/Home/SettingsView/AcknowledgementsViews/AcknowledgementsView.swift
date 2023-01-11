//
//  AcknowledgementsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct AcknowledgementsView: View {
    
    @State var dummy : Bool = false
    
    var body: some View {
        
        Form {
            
            AcknowledgementItem(image: "lunacImage", name: "Lunac", message: "ThankLunac", iconType: "globe", url: Constants.URL.lunac)
            
            AcknowledgementItem(image: "julianImage", name: "Julian", message: "ThankJulian", iconType: "github", url: Constants.URL.julian)
            
            AcknowledgementItem(image: "sivelswhyImage", name: "sivelswhy", message: "ThankTranslator", iconType: "github", url: Constants.URL.sivelswhy)
            
            AcknowledgementItem(image: "xMasaImage", name: "xMasa", message: "ThankTranslator", iconType: "github", url: Constants.URL.xMasa)
            
            Section(header: Text("")) {
                EmptyView()
                
            }
            
        }
        .navigationTitle(LocalizedStringKey("Acknowledgements"))

    }
}



