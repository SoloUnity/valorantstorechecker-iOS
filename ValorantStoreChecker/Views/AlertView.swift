//
//  AlertView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-29.
//

import SwiftUI

struct AlertView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @EnvironmentObject private var alertModel : AlertModel
    @EnvironmentObject private var updateModel : UpdateModel
    @AppStorage("rememberPassword") var rememberPassword = false
    @AppStorage("clickedReview") var clickedReview : Bool = false
    @AppStorage("showUpdate") var showUpdate : Bool = false
    @AppStorage("selectedTab") var selectedTab: Tab = .shop
    @State var update : Bool = false
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {

            if alertModel.alertNoNetwork {
                
                VStack {
                    Image(systemName: "wifi.exclamationmark")
                        .resizable()
                        .scaledToFit()
                    
                    //LOCALIZETEXT
                    Text("NetworkError")
                        .multilineTextAlignment(.center)
                }
                .padding(35)
                .frame(width: 200, height: 200)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .onAppear{
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                        withAnimation(.easeOut) {
                            alertModel.alertNoNetwork = false
                        }
                        timer.invalidate()
                    }
                }
            }
            
            Color.clear
                .frame(width: 0, height: 0)
            // Update Sheet
                .sheet(isPresented: $update, content: {
                    UpdatesView()
                })
            // MARK: Error Messages
                .alert(LocalizedStringKey("ErrorTitle"), isPresented: $authAPIModel.error, actions: {
                    
                    if authAPIModel.errorReloading && rememberPassword {
                        
                        Button(LocalizedStringKey("Settings"), role: nil, action: {
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloadAnimation = false
                            }
                            
                            authAPIModel.errorReloading = false
                            selectedTab = .settings
                            
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
                                
                                alertModel.openAccounts = true
                                
                                timer.invalidate()
                            }
                            
                            authAPIModel.errorReloading = false
                        })
                        
                    }
                    else if authAPIModel.errorReloading {
                        
                        Button(LocalizedStringKey("SignOut"), role: nil, action: {
                            
                            authAPIModel.logOut()
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloadAnimation = false
                            }
                            
                            authAPIModel.errorReloading = false
                        })
                        
                        
                        Button(LocalizedStringKey("Settings"), role: nil, action: {
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloadAnimation = false
                            }
                            
                            authAPIModel.errorReloading = false
                            selectedTab = .settings
                            
                            
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
                                
                                alertModel.openAccounts = true
                                
                                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
                                    
                                    rememberPassword = true
                                    
                                    timer.invalidate()
                                }
                                
                                timer.invalidate()
                            }

                        })
                        
                    }
                    else {
                        
                        Button(LocalizedStringKey("CopyError"), role: nil, action: {
                            
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = authAPIModel.errorMessage
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloadAnimation = false
                            }
                            
                            authAPIModel.errorReloading = false
                            
                        })
                        
                        Button(LocalizedStringKey("OK"), role: nil, action: {
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloadAnimation = false
                            }
                            
                            authAPIModel.errorReloading = false
                            
                        })
                        
                    }
                    
                }, message: {
                    
                    if authAPIModel.errorReloading && rememberPassword {
                        
                        Text(LocalizedStringKey("ErrorMessage2"))
                    }
                    else if authAPIModel.errorReloading {
                        
                        // Big Reload Prompt
                        Text(LocalizedStringKey("ErrorMessage1"))
                        
                    }
                    else {
                        Text(authAPIModel.errorMessage)
                    }
                    
                })
            // MARK: Information Alerts
                .alert(LocalizedStringKey("InformationTitle"), isPresented: $alertModel.alertLoginInfo, actions: {
                    
                    Button(LocalizedStringKey("FAQ"), role: nil, action: {
                        
                        if let url = URL(string: Constants.URL.faq) {
                            UIApplication.shared.open(url)
                        }
                        
                        alertModel.alertLoginInfo = false
                        
                    })
                    
                    Button(LocalizedStringKey("OK"), role: nil, action: {
                        alertModel.alertLoginInfo = false
                    })
                    
                }, message: {
                    let info = LocalizedStringKey("Information")
                    Text(info)
                })
                .alert("InvalidLogin", isPresented: $alertModel.alertBugInfo, actions: {
                    
                    Button(LocalizedStringKey("Reset"), role: nil, action: {
                        
                        authAPIModel.logOut()
                        
                        withAnimation(.easeIn) {
                            authAPIModel.reloadAnimation = false
                        }
                        
                        authAPIModel.errorReloading = false
                        
                        alertModel.alertBugInfo = false
                    })
                    
                    Button(LocalizedStringKey("OK"), role: nil, action: {
                        alertModel.alertBugInfo = false
                    })
                    
                }, message: {
                    let info = LocalizedStringKey("ResetInfo")
                    Text(info)
                })
            // SkinCardDetailView Alert
                .alert(isPresented: $alertModel.alertPriceInfo) { () -> Alert in
                    Alert(title: Text(LocalizedStringKey("InfoPrice")))
                }
            // MARK: ShopTopBarView
                .alert(LocalizedStringKey("ReviewTitle"), isPresented: $alertModel.alertPromptReview , actions: {
                    
                    Button("⭐⭐⭐⭐⭐", role: nil, action: {
                        
                        if let url = URL(string: Constants.URL.review) {
                            UIApplication.shared.open(url)
                        }
                        
                        clickedReview = true
                        
                        alertModel.alertPromptReview = false
                        
                    })
                    
                    Button(LocalizedStringKey("OpenGitHub"), role: nil, action: {
                        
                        if let url = URL(string: Constants.URL.sourceCode) {
                            UIApplication.shared.open(url)
                        }
                        
                        clickedReview = true
                        
                        alertModel.alertPromptReview = false
                        
                        
                    })
                    
                    Button(LocalizedStringKey("MaybeLater"), role: nil, action: {
                        
                        alertModel.alertPromptReview = false
                    })
                    
                    Button(LocalizedStringKey("NeverShowAgain"), role: nil, action: {
                        
                        clickedReview = true
                        
                        alertModel.alertPromptReview = false
                        
                    })
                    
                }, message: {
                    
                    Text("ReviewPrompt")
                    
                    
                })
            // MARK: TipView Alerts
                .alert(LocalizedStringKey("ErrorTitle"), isPresented: $alertModel.alertTipError, actions: {
                    
                    Button(LocalizedStringKey("OK"), role: nil, action: {
                        alertModel.alertTipError = false
                    })
                    
                    
                }, message: {
                    
                    Text(LocalizedStringKey("ErrorMessage3"))
                    
                })
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
