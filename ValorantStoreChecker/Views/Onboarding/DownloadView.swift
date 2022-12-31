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
            
            CommunityView()
                .bgClear()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.bottom)

                          
            
            // MARK: Download Button
            if !authAPIModel.downloadImagePermission {
                
                Button {

                    DispatchQueue.main.async {
                        withAnimation(.easeOut(duration: 0.2)) {
                            UserDefaults.standard.set(true, forKey: "authorizeDownload")
                            authAPIModel.downloadImagePermission = true
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
                            .bold()
                        
                        Spacer()
                        
                        if error {
                            Button {

                                skinModel.progressNumerator = 0
                                skinModel.progressDenominator = 0
                                
                                DispatchQueue.main.async {
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        UserDefaults.standard.set(true, forKey: "authorizeDownload")
                                        authAPIModel.downloadImagePermission = true
                                    }
                                }
                                
                                let backgroundQueue = DispatchQueue.global(qos: .background)
                                
                                backgroundQueue.async {
                                    skinModel.getRemoteData()
                                }
                                
                            } label: {
                                
                                Text("Stuck? Click to Try Again.")
                                
                            }
                        }
                        else {
                            
                            Text(String(Int(skinModel.progressNumerator))).bold() + Text("/" + String(Int(skinModel.progressDenominator))).bold()
                            
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
        .padding(.vertical, 30)
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
        
    }
    
    return round(fraction * 100) / 100
    
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}

