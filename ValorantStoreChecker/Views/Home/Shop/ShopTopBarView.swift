//
//  ShopTopBarView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-30.
//

import SwiftUI

struct ShopTopBarView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var skinModel : SkinModel
    @EnvironmentObject var updateModel : UpdateModel
    @AppStorage("showUpdate") var showUpdate : Bool = false
    @State private var nowDate: Date = Date()
    @State private var successfulReload = false
    @State private var promptReview = false
    
    let reloadType : String
    let defaults = UserDefaults.standard
    let referenceDate: Date
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                // MARK: Countdown timer
                Image(systemName: "clock")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .white, radius: 1)
                    .frame(width: 15, height: 15)
                
                let countdown = countDownString(from: referenceDate, nowDate: nowDate)
                
                if countdown == "Reload" && (authAPIModel.autoReload || defaults.bool(forKey: "autoReload")) {
                    
                    // Automatic reloading
                    Text(LocalizedStringKey("Reloading"))
                        .bold()
                        .onAppear {
                            Task {
                                authAPIModel.reloading = true
                                await authAPIModel.reload(skinModel: skinModel, reloadType: reloadType)
                            }
                        }
                        .font(.caption)
                    
                }
                else if countdown == "Reload" {
                    
                    Text(LocalizedStringKey("Reload"))
                        .bold()
                        .font(.caption)
                    
                }
                else {
                    Text(countdown)
                        .bold()
                        .onAppear(perform: {
                            _ = self.timer
                        })
                        .font(.caption)
                    
                }
                
                Spacer()
                
                if reloadType != "nightMarketReload" {
                    // MARK: Store refresh button
                    Button {
                        
                        withAnimation(.easeIn(duration: 0.2)) {
                            authAPIModel.reloading = true
                        }
                        
                        
                        Task{
                            await authAPIModel.reload(skinModel: skinModel, reloadType: reloadType)
                        }
                        
                        if !defaults.bool(forKey: "clickedReview") {
                            reloadCounter(promptReview: &promptReview)
                        }
                        
                        
                    } label: {
                        if !authAPIModel.reloading && !successfulReload {
                            
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .shadow(color: .pink, radius: 1)
                                .frame(width: 15, height: 15)
                            
                        }
                        
                        else if authAPIModel.reloading {
                            ProgressView()
                                .shadow(color: .white, radius: 1)
                                .frame(width: 15, height: 15)
                                .onAppear{
                                    
                                    // TODO: Fix and make smooth animation
                                    withAnimation(.easeIn(duration: 0.2)) {
                                        self.successfulReload = true
                                    }
                                    
                                }
                        }
                        
                        else if successfulReload {
                            
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .shadow(color: .white, radius: 1)
                                .frame(width: 15, height: 15)
                                .onAppear{
                                    
                                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                                        withAnimation(.easeIn(duration: 0.2)) {
                                            self.successfulReload = false
                                        }
                                        timer.invalidate()
                                    }
                                }
                            
                        }
                        
                        
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 5)
            
            // MARK: Update
            
            if updateModel.update && showUpdate {
                
                UpdateButton()
                
            }
            
            
        }
        .alert(LocalizedStringKey("ReviewTitle"), isPresented: $promptReview, actions: {
            
            Button("⭐⭐⭐⭐⭐", role: nil, action: {
                
                self.promptReview = false
                
                defaults.set(true, forKey: "clickedReview")
                
                if let url = URL(string: Constants.URL.review) {
                    UIApplication.shared.open(url)
                }
                
            })
            
            Button(LocalizedStringKey("OpenGitHub"), role: nil, action: {
                if let url = URL(string: Constants.URL.sourceCode) {
                    UIApplication.shared.open(url)
                }
                
                defaults.set(true, forKey: "clickedReview")
                
                self.promptReview = false
            })
            
            Button(LocalizedStringKey("MaybeLater"), role: nil, action: {
                self.promptReview = false
            })
            
            Button(LocalizedStringKey("NeverShowAgain"), role: nil, action: {
                
                defaults.set(true, forKey: "clickedReview")
                self.promptReview = false
            })
            
        }, message: {
            
            Text("ReviewPrompt")
            
            
        })
    }
    
}

// MARK: Helper function
func countDownString(from date: Date, nowDate: Date) -> String {
    let calendar = Calendar(identifier: .gregorian)
    
    let components = calendar
        .dateComponents([.day, .hour, .minute, .second],
                        from: nowDate,
                        to: date)
    
    if components.day! > 0 && (components.hour! > 0 || components.minute! > 0 || components.second! > 0) {
        return String(format: "%02d:%02d:%02d:%02d",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    else if components.hour! > 0 || components.minute! > 0 || components.second! > 0 {
        return String(format: "%02d:%02d:%02d",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    else {
        
        return "Reload"
        
    }
    
}

func reloadCounter(promptReview: inout Bool) {
    
    let defaults = UserDefaults.standard
    
    let reloadCount = defaults.integer(forKey: "reloadCounter")
    defaults.set(reloadCount + 1, forKey: "reloadCounter")
    
    if (reloadCount != 0) && (reloadCount % 10) == 0 {
        promptReview = true
    }
    
}



