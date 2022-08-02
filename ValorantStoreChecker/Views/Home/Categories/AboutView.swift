//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct AboutView: View {
    
    @EnvironmentObject var skinModel : SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    @State var dark = false
    @State var isDetailViewShowing = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        GeometryReader{ geo in
            
            VStack(alignment: .leading, spacing: 10){
                
                Text("Account")
                    .font(.title)
                    .bold()
                
                //Toggle("Wish List Notifications", isOn: $dark)
                //    .tint(.pink)
                
                HStack{
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text ("Username")
                            .bold()
                        Text(defaults.string(forKey: "username") ?? "")
                        .font(.footnote)
                        
                    }
                }
                
                HStack{
                    
                    switch defaults.string(forKey: "region") ?? ""{
                    case "na":
                        
                        Image(systemName: "globe.americas.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text ("Region")
                                .bold()
                            Text("North America")
                                .font(.footnote)
                        }
                        
                    case "eu":
                        Image(systemName: "globe.europe.africa")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text ("Region")
                                .bold()
                            Text("Europe")
                            .font(.footnote)
                            
                        }
                        
                    case "ap":
                        Image(systemName: "globe.asia.australia.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text ("Region")
                                .bold()
                            Text("Asia Pacific")
                                .font(.footnote)
                        }
                        
                    case "kr":
                        Image(systemName: "globe.asia.australia.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text ("Region")
                                .bold()
                            Text("South korea")
                                .font(.footnote)
                        }
                        
                    default:
                        Image(systemName: "globe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text ("Region")
                                .bold()
                            Text("North America")
                                .font(.footnote)
                            
                        }
                    }
                }
                
                Spacer()
                
                
                Button {
                    
                    authAPIModel.signout()
                    
                } label: {
                    
                    ZStack{
                        
                        RectangleView(colour: .pink)
                            .frame(height: 48)
                            .shadow(color: .pink, radius: 5)
                        
                        Text("Log Out")
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                }
                
                
            }
            .foregroundColor(.white)
        }
        .padding()
        .padding(10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}



