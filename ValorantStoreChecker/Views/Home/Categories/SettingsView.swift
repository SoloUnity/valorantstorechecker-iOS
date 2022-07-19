//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SettingsView: View {
    
    @State var dark = false
    @State var isDetailViewShowing = false
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(alignment: .leading){
                
                Text("Settings")
                    .font(.title)
                    .bold()
                
                Toggle("Wish List Notifications", isOn: $dark)
                    .tint(.pink)
                     
                // TODO: Send user back to default login screen
                Button {
                    isDetailViewShowing = true
                } label: {
                    ZStack{
                        RectangleView(colour: .pink)
                            .frame(height: 48)
                            .shadow(color: .pink, radius: 5)
                        Text("Log Out")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .sheet(isPresented: $isDetailViewShowing) {
                    LoginView()
                }
                Spacer()
            }
            .foregroundColor(.white)
        }
        .padding()
        .padding(10)
        
        
        
            
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
}



