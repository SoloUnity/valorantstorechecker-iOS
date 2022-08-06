//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import SwiftUI


struct LaunchView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @EnvironmentObject var loginModel:AuthAPIModel
    
    @State private var loadingBar : Bool = false
    @State private var percent : Int = 0
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack (alignment: .top){
            
            
            // Displays login if the user is not authenticated
            if !loginModel.isAuthenticated && !defaults.bool(forKey: "authentication") {
                
                LoginView()
                
            }
            else {
                
                HomeView()
                
            }
            
            // Fake loading bar
            if !loadingBar && !UserDefaults.standard.bool(forKey: "progress") {
                
                VStack {
                    
                    ZStack (alignment: .leading){
                        RoundedRectangle (cornerRadius: 20, style: .continuous)
                            .frame (width: UIScreen.main.bounds.width - 50, height: 2)
                            .foregroundColor(Color.white.opacity (0.1))
                        
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .frame(width: (UIScreen.main.bounds.width - 50) * CGFloat(self.percent), height: 2)
                            .foregroundColor(.pink)
                            .animation(.linear(duration: 30), value: self.percent)
                            .onAppear{
                                self.percent = 1
                                
                                Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
                                    withAnimation(.easeIn(duration: 1)) {
                                        self.loadingBar = true
                                    }
                                    defaults.set(true, forKey: "progress")
                                    timer.invalidate()
                                }
                            }
                    }
                    
                    
                    
                    Text("Downloading Assets (60mb)")
                        .font(.caption2)
                    
                }
                .padding(.top, 5)
                
                
            }
            
        }
        .alert(isPresented: $loginModel.isError) { () -> Alert in
            Alert(title: Text(loginModel.errorMessage),
                  primaryButton: .default(Text("OK")) {
                loginModel.isError = false
            },
                  secondaryButton: .default(Text("Copy Error")) {
                
                let pasteboard = UIPasteboard.general
                pasteboard.string = loginModel.errorMessage
                
            }
            
            )
        }
        
        
        
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
