//
//  AccountView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    let defaults = UserDefaults.standard
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 20){
                
                HStack{
                    Text("Account")
                        .bold()
                        .font(.title3)
                    
                    Spacer()
                    
                    Button {
                        
                        authAPIModel.logOut()
                        
                    } label: {
                        Text("Sign Out")
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
