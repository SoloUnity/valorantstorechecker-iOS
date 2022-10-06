//
//  AdPaddingView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-27.
//

import SwiftUI
//import GoogleMobileAds

struct AdPaddingView: View {
    var body: some View {
        
        
        Spacer()
            //.frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
            .padding(.vertical)
         
    }
}

struct AdPaddingView_Previews: PreviewProvider {
    static var previews: some View {
        AdPaddingView()
    }
}
