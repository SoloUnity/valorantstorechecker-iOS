//
//  CustomBannerView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-27.
//

import SwiftUI
//import GoogleMobileAds

let showAds = false

struct CustomBannerView: View {
    var body: some View {
        
        if showAds {
            HStack {
                Spacer()
                /*
                GADBannerViewController()
                    .frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
                    .padding(.vertical, 7.5)
                */
                
                Spacer()
            }
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
}

