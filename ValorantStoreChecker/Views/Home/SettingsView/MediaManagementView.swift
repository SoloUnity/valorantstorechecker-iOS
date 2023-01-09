//
//  MediaManagementView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-29.
//

import SwiftUI

struct MediaManagementView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    @AppStorage("networkType") var networkType = "both"
    @AppStorage("autoPlay") var autoPlay = true
    @State var dummy = false
    @State var loading = false
    let defaults = UserDefaults.standard
    
    var body: some View {
        Form {
            Section() {
                
                //LOCALIZETEXT
                SettingItemView(itemType: "toggle", name: "AutoplayVideos", iconBG: .orange, iconColour: .white, image: "arrowtriangle.forward.circle.fill", toggleBool: $autoPlay)
                
                HStack{
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.teal)
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.trailing)
                    
                    // LOCALIZETEXT
                    Text(LocalizedStringKey("DownloadNewAssets"))
                    
                    Spacer()

                    HStack {
                        
                        //LOCALIZETEXT
                        Picker("", selection: $networkType){
                            
                            Text("Both")
                                .tag("both")
                            
                            Text("WifiOnly")
                                .tag("wifi")
                            
                            Text("CellularOnly")
                                .tag("cellular")
                            
                            Text("Never")
                                .tag("never")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .multilineTextAlignment(.leading)
                        
                        if #available(iOS 16, *) {
                            // code that should only run on iOS 16 and above
                        } else {
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.pink)
                        }
                        
                        
                    }
                    

                }
                
                ZStack {
                    
                    SettingItemView(itemType: "generic", name: "ClearAssets", iconBG: .gray, iconColour: .white, image: "trash", removeSpace : false, toggleBool: $dummy)
                    
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
                                    
                                    withAnimation(.easeIn) {
                                        defaults.set(false, forKey: "authorizeDownload")
                                    }
                                    
                                    defaults.set(false, forKey: "downloadBarFinish")
                                    
                                    authAPIModel.downloadBarFinish = false
                                    authAPIModel.downloadButtonClicked = false
                                }
                                
                                
                                
                                
                            } label: {
                                Text("Clear")
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("ManageMedia")
    }
}

struct MediaManagementView_Previews: PreviewProvider {
    static var previews: some View {
        MediaManagementView()
    }
}
