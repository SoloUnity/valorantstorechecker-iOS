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
                    Text("No Network")
                        .multilineTextAlignment(.center)
                }
                .padding(35)
                .frame(width: 200, height: 200)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .onAppear{
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                        withAnimation(.easeOut) {
                            alertModel.alertNoNetwork = false
                        }
                        timer.invalidate()
                    }
                }
            }
            
            if updateModel.update {
                
                VStack() {
                    
                    VStack {
                        
                        Image(systemName: "chevron.up.circle")
                            .resizable()
                            .scaledToFit()
                            
                        //LOCALIZETEXT
                        Text("New Update Available")
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(.horizontal, 50)
                    .padding(.top)
                    
                    Divider()
                    
                    Text(LocalizedStringKey("Update"))
                        .foregroundColor(.pink)
                        .onTapGesture {
                            
                            self.update = true
                        }
                        
                    
                    Divider()
                    
                    Button {
                        withAnimation(.easeOut) {
                            updateModel.update = false
                        }
                    } label: {
                        Text("OK")
                            .padding(.bottom, 10)
                    }

                }
                .frame(width: 200)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .onAppear {
                    
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                        withAnimation(.easeOut) {
                            updateModel.update = false
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
                .alert(LocalizedStringKey("ErrorTitle"), isPresented: $authAPIModel.isError, actions: {
                    
                    if authAPIModel.isReloadingError && rememberPassword {
                        
                        Button(LocalizedStringKey("OK"), role: nil, action: {
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloading = false
                            }
                            
                            authAPIModel.isReloadingError = false
                        })
                        
                    }
                    else if authAPIModel.isReloadingError {
                        
                        Button(LocalizedStringKey("SignOut"), role: nil, action: {
                            
                            authAPIModel.logOut()
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloading = false
                            }
                            
                            authAPIModel.isReloadingError = false
                        })
                        
                        
                        Button(LocalizedStringKey("OK"), role: nil, action: {
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloading = false
                            }
                            
                            authAPIModel.isReloadingError = false
                        })
                        
                    }
                    else {
                        
                        Button(LocalizedStringKey("CopyError"), role: nil, action: {
                            
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = authAPIModel.errorMessage
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloading = false
                            }
                            
                            authAPIModel.isReloadingError = false
                            
                        })
                        
                        Button(LocalizedStringKey("OK"), role: nil, action: {
                            
                            withAnimation(.easeIn) {
                                authAPIModel.reloading = false
                            }
                            
                            authAPIModel.isReloadingError = false
                            
                        })
                        
                    }
                    
                }, message: {
                    
                    if authAPIModel.isReloadingError && rememberPassword {
                        
                        Text(LocalizedStringKey("ErrorMessage2"))
                    }
                    else if authAPIModel.isReloadingError {
                        
                        // Big Reload Prompt
                        Text(LocalizedStringKey("ErrorMessage1"))
                    }
                    else {
                        Text(authAPIModel.errorMessage)
                    }
                                    
                })
                // MARK: Information Alerts
                .alert(LocalizedStringKey("InformationTitle"), isPresented: $alertModel.alertLoginInfo, actions: {
                    
                    Button(LocalizedStringKey("OpenLink"), role: nil, action: {
                        
                        if let url = URL(string: Constants.URL.sourceCode) {
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
                .alert("Invalid login", isPresented: $alertModel.alertBugInfo, actions: {
                    
                    Button(LocalizedStringKey("Reset"), role: nil, action: {
                        
                        authAPIModel.logOut()
                        
                        withAnimation(.easeIn) {
                            authAPIModel.reloading = false
                        }
                        
                        authAPIModel.isReloadingError = false
                        
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
