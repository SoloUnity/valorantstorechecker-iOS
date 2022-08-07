//
//  AccountView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI
import Keychain

struct AccountView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    
    let defaults = UserDefaults.standard
    let keychain = Keychain()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 20){
                
                HStack{
                    Text(LocalizedStringKey("Account"))
                        .bold()
                        .font(.title3)
                    
                    Spacer()
                    
                    Button {
                        
                        authAPIModel.logOut()
                        
                    } label: {
                        Text(LocalizedStringKey("SignOut"))
                            .font(.callout)
                            .foregroundColor(.pink)
                    }
                }
                
                
                HStack{
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text (LocalizedStringKey("Username"))
                            .bold()
                        Text(keychain.value(forKey: "username") as? String ?? "")
                            .font(.footnote)
                        
                    }
                }
                
                HStack{
                    
                    switch keychain.value(forKey: "region") as? String ?? "na" {
                    case "na":
                        
                        Image(systemName: "globe.americas.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text (LocalizedStringKey("Region"))
                                .bold()
                            Text(LocalizedStringKey("North America"))
                                .font(.footnote)
                        }
                        
                    case "eu":
                        Image(systemName: "globe.europe.africa")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text (LocalizedStringKey("Region"))
                                .bold()
                            Text(LocalizedStringKey("Europe"))
                                .font(.footnote)
                            
                        }
                        
                    case "ap":
                        Image(systemName: "globe.asia.australia.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text (LocalizedStringKey("Region"))
                                .bold()
                            Text(LocalizedStringKey("Asia Pacific"))
                                .font(.footnote)
                        }
                        
                    case "kr":
                        Image(systemName: "globe.asia.australia.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text (LocalizedStringKey("Region"))
                                .bold()
                            Text(LocalizedStringKey("South korea"))
                                .font(.footnote)
                        }
                        
                    default:
                        Image(systemName: "globe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text (LocalizedStringKey("Region"))
                                .bold()
                            Text(LocalizedStringKey("North America"))
                                .font(.footnote)
                            
                        }
                    }
                }
                

                
                
                
            }
            .padding()
            
            Spacer()
        }
        .foregroundColor(.white)
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
