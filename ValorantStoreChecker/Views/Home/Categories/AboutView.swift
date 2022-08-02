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
            
            ScrollView(showsIndicators: false){
                VStack (spacing: 20){
                    
                    HStack{
                        Text("About")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            
                            authAPIModel.signout()
                            
                        } label: {
                            Text("Sign Out")
                                .font(.callout)
                                .foregroundColor(.pink)
                        }
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 20){
                            
                            Text("Account")
                                .bold()
                                .font(.title3)
                            
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
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Support")
                                .bold()
                                .font(.title3)
                            
                            HStack{
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://discord.com/channels/781946764168658984/983281981368467486") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("Create a Support Ticket")
                                        .bold()
                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                            HStack{
                                Image(systemName: "list.bullet.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://github.com/SoloUnity/Valorant-Store-Checker-App/blob/main/README.md#frequently-asked-questions") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("FAQ")
                                        .bold()

                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                            HStack{
                                Image("github")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://github.com/SoloUnity/Valorant-Store-Checker-App") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("Source Code")
                                        .bold()
                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
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
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Community")
                                .bold()
                                .font(.title3)
                            
                            HStack{
                                Image(systemName: "globe")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://valorantstore.net") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("Website")
                                        .bold()

                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                            HStack{
                                Image("discord")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://discord.gg/vK5mzjvqYM") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("Discord Server")
                                        .bold()
                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                            
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
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
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Help Out the Developper!")
                                .bold()
                                .font(.title3)
                            
                            Text("Hi! I'm a sleep deprived university student just trying to make life a little bit better 😄. Please consider helping me out through any method below!")
                            
                            HStack{
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("Leave a Review")
                                        .bold()

                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                            HStack{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://github.com/sponsors/SoloUnity?frequency=one-time") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    Text("Sponsor Me")
                                        .bold()
                                    
                                    Image(systemName: "link")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing)
                                }
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
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
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Acknowledgements")
                                .bold()
                                .font(.title3)
                            
                            
                            HStack{
                                Image("github")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://github.com/juliand665") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text("juliand665")
                                                .bold()
                                            
                                            Image(systemName: "link")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 15, height: 15)
                                                    .padding(.trailing)
                                        }
                                        
                                        
                                        Text("Thank you for your help in answering my many questions!")
                                            .font(.footnote)
                                        
                                    }
                                    
                                    Spacer()

                                    
                                    
                                }
                                
                            }
                            
                            HStack{
                                Image("github")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Button {
                                    if let url = URL(string: "https://github.com/Lunac-dev") {
                                           UIApplication.shared.open(url)
                                        }
                                } label: {
                                    
                                    VStack(alignment: .leading) {
                                        HStack{
                                            Text("Lunac")
                                                .bold()
                                            
                                            Image(systemName: "link")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 15, height: 15)
                                                    .padding(.trailing)
                                        }
                                        
                                        Text("Thank you for your continuous support!")
                                            .font(.footnote)
                                        
                                    }
                                    

                                    Spacer()
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
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
                    
                    HStack {
                        Spacer()
                        
                        Text("Made in SwiftUI")
                        
                        Image("swiftui")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    .padding()
                    
                }
            }
            
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}



