//
//  DownloadAuthorization.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-11-05.
//

import SwiftUI

struct DownloadView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @EnvironmentObject private var skinModel : SkinModel
    
    @State private var expandCommunity = true
    @State private var expandAcknowledgements = true
    @State private var expandCopyright = false
    @State private var percent : Int = 0
    
    var body: some View {
        
        GeometryReader { geo in
            
            HStack {
                Spacer()
                
                VStack(spacing: 15) {

                    Logo()
                        .frame(width: UIScreen.main.bounds.width/Constants.dimensions.logoSize, height: UIScreen.main.bounds.height/Constants.dimensions.logoSize)
                    
                    TabView {
                        
                        

                        Button {
                            if let url = URL(string: Constants.URL.website) {
                                UIApplication.shared.open(url)
                            }
                        } label: {

                            VStack {
                                Image("website")
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(15)
                                
                                Spacer()
                            }

                        }
                        

                        Button {
                            if let url = URL(string: Constants.URL.discord) {
                                UIApplication.shared.open(url)
                            }
                        } label: {

                            VStack {
                                Image("discordServer")
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(15)
                                
                                Spacer()
                            }

                        }
                        
                        VStack{
                            ScrollView(showsIndicators: false) {
                                CommunityView(expand: $expandCommunity)
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
                                            
                                
                                AcknowledgementsView(expand: $expandAcknowledgements)
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
                                
                                CopyrightView(expand: $expandCopyright)
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
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .padding(.horizontal)
                    
                                  
                    Spacer()
                    
                    if !authAPIModel.downloadImagePermission {
                        Button {

                            DispatchQueue.main.async {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    UserDefaults.standard.set(true, forKey: "authorizeDownload")
                                    authAPIModel.downloadImagePermission = true
                                }
                            }
                            
                            
                            Task {
                                
                                await skinModel.getRemoteData()
                            }
                            
                        } label: {
                            
                            ZStack{
                                RectangleView(colour: .pink)
                                    .shadow(color:.pink, radius: 2)
                                    .cornerRadius(15)
                                
                                Text("DownloadAssets")
                                    .bold()
                                    .padding(15)
                                    .foregroundColor(.white)
                                    
                                
                            }
                            .padding(.horizontal)
                            .frame(height: Constants.dimensions.circleButtonSize)
                            
                        }
                    }
                    else {
                        
                        ZStack (alignment: .leading){
                            RoundedRectangle (cornerRadius: 20, style: .continuous)
                                .frame (width: UIScreen.main.bounds.width - 50, height: 10)
                                .foregroundColor(Color.white.opacity (0.1))
                            
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(width: (UIScreen.main.bounds.width - 50) * CGFloat(self.percent), height: 10)
                                .foregroundColor(.pink)
                                .animation(.linear(duration: 15), value: self.percent)
                                .onAppear{
                                    self.percent = 1
                                    
                                    Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                                        
                                        DispatchQueue.main.async {
                                            withAnimation(.easeOut(duration: 0.2)) {
                                                UserDefaults.standard.set(true, forKey: "downloadBarFinish")
                                                authAPIModel.downloadBarFinish = true
                                            }
                                        }
                                        
                                        
                                        timer.invalidate()
                                    }
                                }
                        }
                        
                    }
                    
                    Spacer()
                    

                }
                .padding(.vertical, 30)
                
                
                Spacer()
            }
            
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
        .animation(.spring(), value: expandCommunity)
        .animation(.spring(), value: expandAcknowledgements)
        .animation(.spring(), value: expandCopyright)
        
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}

