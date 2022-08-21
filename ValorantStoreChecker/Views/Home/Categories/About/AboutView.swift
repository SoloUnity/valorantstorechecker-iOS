//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct AboutView: View {
    
    @State var showSettings = false
    @State var expand = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        GeometryReader{ geo in
            
            ScrollView(showsIndicators: false){
                LazyVStack (spacing: 20){
                    
                    HStack{
                        Text(LocalizedStringKey("About"))
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        
                        Button {
                            
                            self.showSettings = true
                            
                        } label: {
                            
                            Image(systemName: "gear")
                            
                        }
                        
                        
                    }
                    
                    AccountView()
                    
                    CommunityView()
                    
                    SupportView()
                    
                    HelpView(expand: $expand)
                    
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
        .sheet(isPresented: $showSettings) {
            SettingsView(referenceDate: defaults.object(forKey: "timeLeft") as? Date ?? Date())
                .preferredColorScheme(.dark)
        }
        .animation(.spring(), value: expand)
    }
}

struct AboutView_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}



