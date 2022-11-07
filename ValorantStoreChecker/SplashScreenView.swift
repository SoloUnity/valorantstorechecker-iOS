//
//  SplashScreenView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-03.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            LaunchView()
                .environmentObject(SkinModel())
                .environmentObject(AuthAPIModel())
                .environmentObject(TipModel())
                .environmentObject(UpdateModel())
        } else{
            
            GeometryReader { geo in
                VStack {
                    
                    Spacer()
                    
                    Logo()
                    
                    
                    Image("textlogo")
                        .resizable()
                        .scaledToFit()
                        .shadow(color:.red, radius: 3)
                    
                    Spacer()
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.85)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                
                
            }
            .padding(120)
            .background(Constants.bgGrey)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {   // Duration of splash screen
                    withAnimation {
                        
                        self.isActive = true
                        
                    }
                    
                }
            }
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
