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
    
    @State private var percent : Int = 0
    @State private var error : Bool = false
    
    var body: some View {
        
        VStack() {

            Logo()
                .frame(height: 70)
              
            Spacer()
            
            VStack {
                
                // Website
                Button {

                    if let url = URL(string: Constants.URL.website) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    
                    VStack(alignment: .leading) {
                        Text("WebAndDisc")
                            .bold()
                            .foregroundColor(.white)
                        
                        Image("websiteImage")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                    
                }
                
                // Discord
                Button {

                    if let url = URL(string: Constants.URL.discord) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    
                    VStack(alignment: .leading) {
                        Text("DiscordServer")
                            .bold()
                            .foregroundColor(.white)
                        
                        Image("discordImage")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                    
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)

            Spacer()
                          
            
            // MARK: Download Button
            if !authAPIModel.downloadButtonClicked {
                
                Button {

                    DispatchQueue.main.async {
                        withAnimation(.easeOut(duration: 0.2)) {
                            UserDefaults.standard.set(true, forKey: "authorizeDownload")
                            authAPIModel.downloadButtonClicked = true
                        }
                    }
                    
                    let backgroundQueue = DispatchQueue.global(qos: .background)
                    
                    backgroundQueue.async {
                        skinModel.getRemoteData()
                    }
                    
                } label: {
                    
                    ZStack{
                        RectangleView()
                            .shadow(color:.pink, radius: 2)
                            .cornerRadius(15)
                        
                        Text("DownloadAssets")
                            .bold()
                            .padding(15)
                            .foregroundColor(.white)
                            
                        
                    }
                    .frame(height: Constants.dimensions.circleButtonSize)
                    
                }
            }
            else {
                
                // MARK: Download Bar
                let progress = modulateProgress(numerator: skinModel.progressNumerator, denominator: skinModel.progressDenominator, authAPIModel: authAPIModel)
                
                VStack {
                    HStack {
                        
                        Text(String(Int(round(progress * 100))) + "%")
                            .foregroundColor(.white)
                            .bold()
                        
                        Spacer()
                        
                        if error {
                            Button {

                                skinModel.progressNumerator = 0
                                skinModel.progressDenominator = 0
                                
                                DispatchQueue.main.async {
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        UserDefaults.standard.set(true, forKey: "authorizeDownload")
                                        authAPIModel.downloadButtonClicked = true
                                    }
                                }
                                
                                
                                self.error = false
                                
                                Timer.scheduledTimer(withTimeInterval: 90, repeats: false) { timer in
                                    withAnimation(.easeOut) {
                                        self.error = true
                                    }
                                    timer.invalidate()
                                }
                                
                                let backgroundQueue = DispatchQueue.global(qos: .background)
                                
                                backgroundQueue.async {
                                    skinModel.getRemoteData()
                                }
                                
                            } label: {
                                
                                // LOCALIZETEXT
                                Text("Stuck? Click to Try Again.")
                                    .foregroundColor(.white)
                                    .bold()
                                    
                                
                                
                            }
                        }
                        else {

                            Text(String(Int(skinModel.progressNumerator))).bold().foregroundColor(.white) + Text("/" + String(Int(skinModel.progressDenominator))).bold().foregroundColor(.white)
                            
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    
                    ZStack (alignment: .leading){
                        
                        RoundedRectangle (cornerRadius: 20, style: .continuous)
                            .frame (width: UIScreen.main.bounds.width - 50, height: 10)
                            .foregroundColor(Color.white.opacity (0.1))
                        
                        // Percent bar that goes up
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .animation(.linear, value: progress)
                            .frame(width: (UIScreen.main.bounds.width - 50) * progress, height: 10)
                            .foregroundColor(.pink)
                        
                    }
                }
                .padding(.bottom, 30)
                .onAppear{
                    Timer.scheduledTimer(withTimeInterval: 90, repeats: false) { timer in
                        withAnimation(.easeOut) {
                            self.error = true
                        }
                        timer.invalidate()
                    }
                }
            }
        }
        .padding(.top, 30)
        .padding(.horizontal)
        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
    }
}

func modulateProgress(numerator: Double, denominator: Double, authAPIModel: AuthAPIModel) -> Double {
    
    if denominator == 0 || numerator == 0 {
        return 0
    }
    
    let fraction = numerator / denominator
    
    if fraction >= 1 {
        
        DispatchQueue.main.async {
            
            withAnimation(.easeIn) {
                UserDefaults.standard.set(true, forKey: "downloadBarFinish")
                authAPIModel.downloadBarFinish = true
            }
        }
        
        return 1
        
    }
    
    return round(fraction * 100) / 100
    
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}

