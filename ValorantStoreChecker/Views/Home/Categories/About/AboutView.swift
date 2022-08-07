//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        
        GeometryReader{ geo in
            
            ScrollView(showsIndicators: false){
                LazyVStack (spacing: 20){
                    
                    HStack{
                        Text(LocalizedStringKey("About"))
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                    }
                    
                    AccountView()
                    
                    SupportView()
                    
                    CommunityView()
                    
                    HelpView()
                    
                    AcknowledgementsView()
                    
                    CopyrightView()
                    
                    HStack {
                        Spacer()
                        
                        Text(LocalizedStringKey("MadeWith"))
                        
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



