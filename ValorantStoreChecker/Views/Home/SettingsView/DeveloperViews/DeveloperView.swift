//
//  DeveloperView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-30.
//

import SwiftUI

struct DeveloperView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    @State var dummy = false
    @State var loading = false
    let defaults = UserDefaults.standard
    
    var body: some View {
        Form {
            ZStack {
                
                
                SettingItemView(itemType: "generic", name: "Clear Assets", iconBG: .gray, iconColour: .white, image: "trash", toggleBool: $dummy)
                
                HStack {
                    Spacer()
                    
                    if loading {
                        ProgressView()
                            .tint(.gray)
                    }
                    else {
                        Button {
                            
                            self.loading = true
                            
                            Task {
                                
                                skinModel.progressNumerator = 0
                                skinModel.progressDenominator = 0
                                await skinModel.deleteData()
                                
                                defaults.set(false, forKey: "authorizeDownload")
                                defaults.set(false, forKey: "downloadBarFinish")
                                authAPIModel.downloadBarFinish = false
                                authAPIModel.downloadImagePermission = false
                            }
                            
                            
                            
                            
                        } label: {
                            Text("Clear")
                        }
                    }
                }
            }
        }
        .navigationTitle("Developer")
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
